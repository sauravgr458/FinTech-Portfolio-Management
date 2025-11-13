require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  let(:org) { Organization.create!(name: 'Org') }
  let!(:contact) { org.contacts.create!(name: 'A', email: 'a@x.com') }
  let!(:template) { EmailTemplate.create!(subject: 'S', body: 'B') }

  it 'index renders' do
    get contacts_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include contact.name
  end

  it 'preview_template returns json' do
    get preview_template_contact_path(contact), params: { template_id: template.id }
    expect(response.content_type).to include 'application/json'
  end
end
