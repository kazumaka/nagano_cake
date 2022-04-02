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
      redirect_to thanks_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_id] == 1
      @order.ship_name = current_customer.name
      @order.ship_postal_code = current_customer.postal_code
      @order.ship_address = current_customer.address
    elsif params[:order][:address_id] == 2
      @order.ship_name = Address.find(params[:order][:address_display]).name
      @order.ship_postal_code = Address.find(params[:order][:address_display]).postal_code
      @order.ship_address = Address.find(params[:order][:address_display]).address
    elsif params[:order][:address_id] == 3
      address_new = current_customer.addresses.new(address_params)
      if address_new.save
      else
        render :new
      end
    else
      redirect_to root_path
    end
    @cart_items = current_customer.cart_items.all
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:ship_postal_code, :ship_address, :ship_name, :repuest_money, :payment, :postage, :status)
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
