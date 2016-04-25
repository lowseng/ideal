class Place < ActiveRecord::Base
  validates :name, presence: true
  has_many :regions, dependent: :destroy
end