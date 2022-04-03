class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.purchase_price = cart_item.item.add_tax_price
        order_detail.save
      end
      cart_items.destroy_all
      redirect_to thanks_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.ship_name = current_customer.last_name + current_customer.first_name
      @order.ship_postal_code = current_customer.postal_code
      @order.ship_postal_address = current_customer.address
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.ship_name = @address.name
      @order.ship_postal_code = @address.postal_code
      @order.ship_postal_address = @address.address
    elsif params[:order][:select_address] == "2"
      address_new = current_customer.orders.new(order_params)
      if
        address_new.save
        @order.ship_name = address_new.ship_name
        @order.ship_postal_code = address_new.ship_postal_code
        @order.ship_postal_address = address_new.ship_postal_address
      else
        render :new
      end
    else
      redirect_to items_path
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @sum = @total.to_i + @order.postage.to_i
  end

  def index
    @order_details = OrderDetail.all
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @order.postage = 800
    @total = @order_details.inject(0) { |sum, item| sum + item.subtotal }
    @sum = @total.to_i + @order.postage.to_i
  end

  private

  def order_params
    params.require(:order).permit(:payment, :ship_postal_code, :ship_postal_address, :ship_name, :request_money)
  end



end
