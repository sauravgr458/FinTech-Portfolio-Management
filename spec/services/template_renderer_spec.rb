require 'rails_helper'

RSpec.describe TemplateRenderer do
  let(:org) { Organization.create!(name: 'Org', email: 'org@x.com') }
  let(:contact) { org.contacts.create!(name: 'Jane', email: 'jane@x.com') }
  let!(:p1) { contact.portfolios.create!(name: 'P1', balance: 1000, performance: 2.5) }
  let!(:p2) { contact.portfolios.create!(name: 'P2', balance: 2000, performance: -1.0) }

  it 'replaces known tokens' do
    tmpl = EmailTemplate.create!(subject: 'Hello {Contact.name}', body: 'Best {Portfolio.best_performance} Worst {Portfolio.worst_performance}')
    out = TemplateRenderer.new(tmpl, contact).render
    expect(out[:subject]).to include 'Jane'
    expect(out[:body]).to include '2.50'
  end

  it 'keeps unknown tokens as-is' do
    tmpl = EmailTemplate.create!(subject: '{Unknown.token}', body: 'X')
    out = TemplateRenderer.new(tmpl, contact).render
    expect(out[:subject]).to include '{Unknown.token}'
  end
end
