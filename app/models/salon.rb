class Salon < ActiveRecord::Base
  belongs_to :location
  has_many :passes, dependent: :destroy
  validates :name, :topic, :detail_location, :time, :detail_info, :guests, :help, :about, presence: true
end
