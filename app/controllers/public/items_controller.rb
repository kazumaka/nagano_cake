class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :get_profile_image)
  end
end
