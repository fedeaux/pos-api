class Table < ApplicationRecord
  singleton_class.send :alias_method, :ensure_amount_create, :create
  singleton_class.send :private, :ensure_amount_create

  # Use strings instead of symbols since active record will store them as strings
  AVAILABLE = 'available'
  DISABLED = 'disabled'
  OCCUPIED = 'occupied'

  after_initialize :ensure_valid_state
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

  def self.create
    raise 'Table.create is disabled, use Table.ensure_amount instead'
  end

  def self.ensure_amount(n)
    if Table.count < n
      (n - Table.count).times do
        ensure_amount_create
      end
    end
  end
end
