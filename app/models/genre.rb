class Genre < ApplicationRecord
  has_many :items, dependent: :destr
end
