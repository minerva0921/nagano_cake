class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    flash[:notice] = "注文ステータスを変更しました"


    if @order.status == "入金確認"
      @order.order_details.each do |order_detail|
        order_detail.update(production_status: 1)
      end
    end
    redirect_to admin_order_path(@order.id)

  end

  def today_order_index

  end

  def current_index

  end

  private

  def order_params
    params.require(:order).permit(:postage,:billing_amount,:name,:payment_method,:address,:postal_code,:status)
  end
end
