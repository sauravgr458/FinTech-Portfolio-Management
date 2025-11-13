class Contact < ApplicationRecord
  belongs_to :organization
  has_many :portfolios, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Return best performance (decimal) among portfolios or nil
  def best_portfolio_performance
    portfolios.maximum(:performance)
  end

  # Return worst performance (decimal) among portfolios or nil
  def worst_portfolio_performance
    portfolios.minimum(:performance)
  end
end
