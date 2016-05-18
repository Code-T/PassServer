class Pass < ActiveRecord::Base
  belongs_to :salon
  validates :user_name, :user_type, :user_phone_number, presence: true
end


# t.string :serial_number
# t.string :authentication_token
# t.string :barcode_message
# t.string :user_name
# t.string :user_phone_number
# t.string :user_type
# t.references :salon, index: true, foreign_key: true
