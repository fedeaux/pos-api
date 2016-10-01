class Waiter < ApplicationRecord
  validates :name, presence: true
  has_many :consumptions
end
