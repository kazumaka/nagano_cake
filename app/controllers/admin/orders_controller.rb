class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0){|sum, order_detail| sum + order_detail.subtotal}
    @order.postage = 800
  end
end
