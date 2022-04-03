class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  def add_tax_purchase_price
  (self.purchase_price * 1.10).round
  end
  
  def subtotal
    add_tax_purchase_price*amount
  end
end
