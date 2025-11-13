# FinTech Portfolio Management System (mini)

## What
A small Rails app implementing:
- Contacts dashboard with portfolios and best/worst performance.
- Email templates with shortcodes and preview/send simulation.
- HAML views and CoffeeScript for simple interactivity.

Spec reference: uploaded assignment. :contentReference[oaicite:1]{index=1}

## Tech
- Ruby (3.2.2), Rails (8.1.1), PostgreSQL
- HAML for views, CoffeeScript for front-end snippets
- RSpec for tests

## Setup
1. Clone repo
2. `bundle install`
3. Configure `config/database.yml` for PostgreSQL
4. `rails db:create db:migrate db:seed`
5. `rails server` and visit `http://localhost:3000` (root -> Contacts Dashboard)

## Tests
Run:
```bash
bundle exec rspec
