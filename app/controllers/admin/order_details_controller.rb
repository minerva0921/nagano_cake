class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order_detail = OrderDetail.find(params[:id])

    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    # 製作ステータスを「製作中(2)」→注文ステータスを「製作中(2)」
    if @order_detail.production_status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "製作ステータスの更新しました。"
      @order.save
    end

    # 注文個数と製作完了になっている個数が同じならば
    if @order.order_details.count == @order.order_details.where(production_status: 3).count
      @order.update(status: 3)
      flash[:notice] = "製作ステータスの更新しました。"
      @order.save
    end

    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :order_quantity, :settlement_amount, :production_status)
    #params.permit(:item_id, :order_id, :order_quantity, :settlement_amount, :production_status)
  end
end
