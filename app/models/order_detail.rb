class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def subtotal
    purchase_price*amount
  end

end
