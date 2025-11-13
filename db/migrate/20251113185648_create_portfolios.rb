class CreatePortfolios < ActiveRecord::Migration[8.1]
  def change
    create_table :portfolios do |t|
      t.string :name, null: false
      t.decimal :balance, default: 0.0
      t.decimal :performance, default: 0.0
      t.integer :contact_id

      t.timestamps
    end
  end
end
