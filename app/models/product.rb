class Product < ApplicationRecord
  belongs_to :user
  validates :name, :unit_price, :quantity, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_city_and_name,
    against: :name,
    associated_against: { user: :city },
    using: {
      tsearch: { prefix: true }
    }
end
