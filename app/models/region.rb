class Region < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false  
  has_many :areas, dependent: :destroy
  belongs_to :place
  validates :place_id, presence: true
end