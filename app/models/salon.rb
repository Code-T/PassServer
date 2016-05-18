class Salon < ActiveRecord::Base
  belongs_to :location
  has_many :passes, dependent: :destroy
end
