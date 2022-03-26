class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment:{credit_card: 0, transfer: 1 }
  
  enum status:{waiting: 0, confirm: 1, making: 2, preparation: 3, shipping: 4}
  
  
end
