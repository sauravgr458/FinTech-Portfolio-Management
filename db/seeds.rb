# Clear
Organization.destroy_all
EmailTemplate.destroy_all

org1 = Organization.create!(name: 'Acme Corp', email: 'org@acme.com')
org2 = Organization.create!(name: 'Globex Inc', email: 'contact@globex.com')

alice = org1.contacts.create!(name: 'Alice Johnson', email: 'alice@example.com')
bob = org2.contacts.create!(name: 'Bob Smith', email: 'bob@example.com')
carol = org1.contacts.create!(name: 'Carol White', email: 'carol@example.com')

alice.portfolios.create!(name: 'Growth Fund', balance: 10000, performance: 15.0)
alice.portfolios.create!(name: 'Income Fund', balance: 5000, performance: -2.0)

bob.portfolios.create!(name: 'Equity Fund', balance: 20000, performance: 8.0)
bob.portfolios.create!(name: 'Bonds Fund', balance: 7500, performance: 3.0)

carol.portfolios.create!(name: 'Balanced Fund', balance: 5000, performance: 4.5)

EmailTemplate.create!(
  subject: 'Monthly Portfolio Digest',
  body: <<~BODY
    Hello {Contact.name},

    Your organization: {Organization.name}

    Best portfolio: {Portfolio.best_performance}%
    Worst portfolio: {Portfolio.worst_performance}%

    Regards,
    FinTech Team
  BODY
)

EmailTemplate.create!(
  subject: 'Welcome to our service',
  body: <<~BODY
    Hi {Contact.name},

    Welcome to {Organization.name}! We will be in touch at {Contact.email}.

    Best,
    Support
  BODY
)
