class Consumption < ApplicationRecord
  belongs_to :table
  validates :state, presence: true
  validates :table, presence: true

  has_many :product_consumptions, dependent: :destroy
  has_many :products, through: :product_consumptions
  has_many :payments
  belongs_to :waiter

  after_initialize :ensure_valid_state
  before_save :update_digest_values

  # Use strings instead of symbols since active record will store them as strings
  OPEN = 'open'
  PAYED = 'payed'
  CANCELED = 'canceled'

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

  def payed?
    self.state == PAYED
  end

  def open?
    self.state == OPEN
  end

  def canceled?
    self.state == CANCELED
  end

  def update_digest_values
    self.total_price = products.reduce(0) { |sum, p| sum + p.price }
    self.payed_value = payments.reduce(0) { |sum, p| sum + p.value }

    if self.payed? and self.state_was != CANCELED
      if self.tip_value.nil? or self.tip_value == 0.0
        self.tip_value = [0, payed_value - total_price].max
      end

      if self.discount_value.nil? or self.discount_value == 0.0
        self.discount_value = [0, total_price - payed_value].max
      end
    end
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
