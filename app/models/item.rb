class Item < ApplicationRecord
  has_one_attached :profile_image
  belongs_to :genre
  has_many :order_details, dependent: :destroy
  has_many :cart_item, dependent: :destroy

  validates :profile_image, presence: true
  validates :genre_id, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def add_tax_price
  (self.price * 1.10).round
  end

end
