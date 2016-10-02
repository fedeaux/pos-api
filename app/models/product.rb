class Product < ApplicationRecord
  belongs_to :category, class_name: :ProductCategory

  validates :category, presence: true
  validates :code, presence: true
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  has_many :product_consumptions, dependent: :destroy

  scope :active, -> { where(active: true) }
end
