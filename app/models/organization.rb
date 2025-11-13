class Organization < ApplicationRecord
  has_many :contacts, dependent: :destroy

  validates :name, presence: true
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
