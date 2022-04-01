class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save
          redirect_to cart_items_path
    else 
          @cart_items = current_customer.cart_items.all
          render "index"
    end
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  def destroy_all
    
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :price)
  end
end