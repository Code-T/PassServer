class CreatePasses < ActiveRecord::Migration
  def change
    create_table :passes do |t|
      t.string :serial_number
      t.string :authentication_token
      t.string :barcode_message
      t.string :user_name
      t.string :user_phone_number
      t.string :user_type
      t.string :real_name
      t.string :company_name
      t.string :github_id
      t.string :mail
      t.references :salon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
