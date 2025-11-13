class EmailTemplate < ApplicationRecord
  validates :subject, :body, presence: true
end
