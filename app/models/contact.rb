class Contact < ApplicationRecord
  belongs_to :organization
  has_many :portfolios, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
