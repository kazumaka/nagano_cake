class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_items = current_customer.cart_items.all
  end
  
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  def destroy_all
    
  end
end
