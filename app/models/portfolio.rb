class Portfolio < ApplicationRecord
  belongs_to :contact

  validates :name, presence: true
  validates :balance, numericality: true
  validates :performance, numericality: true
end
