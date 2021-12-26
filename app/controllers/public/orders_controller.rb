class Public::OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @cart_items = current_customer.cart_items

    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    # billing_amountに請求額を入れる billingはhelperで定義
    @order.postage = 800
    @order.billing_amount = billing(@order)

    # my_address：１（自宅）
    if params[:order][:my_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = full_name(current_customer)

    # my_address：２（登録済配送先）
    elsif params[:order][:my_address] == "2"
      postal = Address.find(params[:order][:address_id])
      @order.postal_code = postal.postal_code
      @order.address = postal.address
      @order.name = postal.name

    # my_address：３(新配送先入力)
    elsif params[:order][:my_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @postal = "1"

    # 有効かどうかの確認
      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save

    # 情報入力に新規配送先があれば保存
    if params[:order][:postal] =="1"
      current_customer.address.create(address_params)
    end

    # カート商品の情報を注文履歴に移動させる
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.order_quantity = cart_item.amount
      @order_detail.settlement_amount = cart_item.item.tax_in_price * cart_item.amount
      @order_detail.save
    end

    # 最後にカートを全て削除する
    @cart_items.destroy_all

    redirect_to thanks_orders_path
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name ,:postage , :payment_method, :billing_amount)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
