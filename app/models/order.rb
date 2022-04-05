class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  validates :ship_postal_code, presence: true
  validates :ship_postal_address, presence: true
  validates :ship_name, presence: true
  validates :request_money, presence: true
  validates :payment, presence: true

  enum payment: {credit_card: 0, transfer: 1 }

  enum status:{waiting: 0, confirm: 1, making: 2, preparation: 3, shipping: 4}


end
