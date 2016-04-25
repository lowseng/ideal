class Region < ActiveRecord::Base
  validates :name, presence: true
  has_many :areas, dependent: :destroy
  belongs_to :place
  validates :place_id, presence: true
end