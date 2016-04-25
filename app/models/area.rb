class Area < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false    
  belongs_to :region
  validates :region_id, presence: true
end