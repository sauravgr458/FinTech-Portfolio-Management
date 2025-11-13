require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe '#best_portfolio_performance and worst' do
    let(:org) { Organization.create!(name: 'Test Org') }
    let(:contact) { org.contacts.create!(name: 'S', email: 's@example.com') }

    it 'returns correct best and worst' do
      contact.portfolios.create!(name: 'A', balance: 100, performance: 5.2)
      contact.portfolios.create!(name: 'B', balance: 200, performance: -1.3)
      expect(contact.best_portfolio_performance).to eq 5.2
      expect(contact.worst_portfolio_performance).to eq -1.3
    end
  end
end
