class Consumption < ApplicationRecord
  belongs_to :table
  validates :state, presence: true
  validates :table, presence: true

  has_many :product_consumptions
  has_many :products, through: :product_consumptions

  # Use strings instead of symbols since active record will store them as strings
  OPEN = 'open'
  PAYED = 'payed'
  CANCELED = 'canceled'

  after_initialize :ensure_valid_state
  def ensure_valid_state
    self.state = Consumption::OPEN unless has_valid_state?
  end

  def state=(state_string)
    super
    ensure_valid_state
  end

  def has_valid_state?
    self.state and [ OPEN, PAYED, CANCELED ].include? self.state
  end

  def has_products?
    products.any?
  end
end
