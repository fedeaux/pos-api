class Consumption < ApplicationRecord
  belongs_to :table
  validates :state, presence: true
  validates :table, presence: true

  has_many :product_consumptions, dependent: :destroy
  has_many :products, through: :product_consumptions

  before_save :update_digest_values

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

  def update_digest_values
    self.total_price = products.reduce(0) { |sum, p| sum + p.price }
  end

  def remove_one_product(product)
    # Rails tells us to use self.products.delete(product), but
    #   doing this leads to all the repetitions being deleted.
    # Added an issue to address this smell.

    products = self.products.to_a
    products.delete_at(products.index(product))
    self.products.delete_all
    self.products = products
    save
  end
end
