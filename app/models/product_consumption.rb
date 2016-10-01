class ProductConsumption < ApplicationRecord
  belongs_to :product
  belongs_to :consumption

  validates :product, presence: true
  validates :consumption, presence: true
end
