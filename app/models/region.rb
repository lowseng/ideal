class Region < ActiveRecord::Base
  belongs_to :place
  has_many :areas
end