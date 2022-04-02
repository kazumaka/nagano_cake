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
      redirect_to order_confirm_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == 0
      @order.ship_name = current_customer.last_name + current_customer.first_name
      @order.ship_postal_code = current_customer.postal_code
      @order.ship_address = current_customer.address
    elsif params[:order][:select_address] == 1
      @address = Address.find(params[:order][:address_id])
      @order.ship_name = @address.name
      @order.ship_postal_code = @address.postal_code
      @order.ship_address = @address.address
    elsif params[:order][:select_address] == 2
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to root_path
    end
    @cart_items = current_customer.cart_items.all
    @order.postage = 800
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:ship_postal_code, :ship_address, :ship_name, :payment)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
