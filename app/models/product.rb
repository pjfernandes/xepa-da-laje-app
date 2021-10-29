class Product < ApplicationRecord
  belongs_to :user
  validates :name, :unit_price, :quantity, presence: true

  has_one_attached :photo

end
