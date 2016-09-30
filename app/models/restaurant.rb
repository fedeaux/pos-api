class Restaurant < ApplicationRecord
  acts_as_singleton
  validates :name, presence: true

  after_validation :set_initialized_flag

  def set_initialized_flag
    self.initialized = self.initialized || self.errors.empty?
  end
end
