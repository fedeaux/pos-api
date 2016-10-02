class Table < ApplicationRecord
  singleton_class.send :private, :create

  # Use strings instead of symbols since active record will store them as strings
  AVAILABLE = 'available'
  DISABLED = 'disabled'
  OCCUPIED = 'occupied'

  after_initialize :ensure_valid_state
  after_save :create_consumption_if_updating_state_to_occupied
  after_save :destroy_consumption_if_updating_state_to_available

  validate :can_be_updated_to_available

  has_many :consumptions

  def active_consumption
    consumptions.where( state: Consumption::OPEN ).first
  end

  def create_consumption_if_updating_state_to_occupied
    if self.occupied? and self.state_was == AVAILABLE
      unless active_consumption
        Consumption.create table: self, state: Consumption::OPEN
      end
    end
  end

  def destroy_consumption_if_updating_state_to_available
    if self.available? and self.state_was == OCCUPIED and active_consumption and !active_consumption.has_products?
      active_consumption.destroy
    end
  end

  def can_be_updated_to_available
    if active_consumption and active_consumption.has_products? and available?
      errors.add(:state, "Can't set table state to available with an open consumption")
    end
  end

  def occupied?
    self.state == OCCUPIED
  end

  def available?
    self.state == AVAILABLE
  end

  def disabled?
    self.state == DISABLED
  end

  def ensure_valid_state
    self.state = Table::AVAILABLE unless has_valid_state?
  end

  def state=(state_string)
    super
    ensure_valid_state
  end

  def has_valid_state?
    self.state and [AVAILABLE, DISABLED, OCCUPIED].include? self.state
  end

  def self.ensure_amount(n)
    if Table.count < n
      (n - Table.count).times do
        create
      end
    end
  end
end
