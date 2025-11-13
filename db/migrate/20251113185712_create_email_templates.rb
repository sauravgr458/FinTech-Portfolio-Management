class CreateEmailTemplates < ActiveRecord::Migration[8.1]
  def change
    create_table :email_templates do |t|
      t.string :subject, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
