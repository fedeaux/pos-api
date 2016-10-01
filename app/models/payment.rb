class Payment < ApplicationRecord
  belongs_to :consumption
  validates :consumption, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }
end
