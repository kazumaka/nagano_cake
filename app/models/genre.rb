class Genre < ApplicationRecord
  has_many :items, dependent: :destro
end
