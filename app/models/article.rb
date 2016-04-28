class Article < ActiveRecord::Base
  belongs_to :user 
  validates :user_id, presence: true
  validates :proptype, presence: true
  validates :place, presence: true
  validates :region, presence: true
  validates :area, presence: true
  
 	validates :title, presence: true, length: {minimum: 3, maximum: 50}
	validates :description, presence: true, length: {minimum: 10, maximum: 300}
	has_many :images, dependent: :destroy
end