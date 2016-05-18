class Location < ActiveRecord::Base
  has_many :salons, dependent: :destroy
  validates :name, presence: true
end
