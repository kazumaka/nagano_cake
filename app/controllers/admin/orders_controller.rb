class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total = @order_details.inject(0){|sum, order_detail| sum + order_detail.subtotal}
    @order.postage = 800
    @customer = @order.customer
  end
end
