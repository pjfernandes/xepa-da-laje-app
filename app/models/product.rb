class Product < ApplicationRecord
  belongs_to :user
  validates :name, :unit_price, :quantity, presence: true

end
