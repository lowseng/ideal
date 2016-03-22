class Article < ActiveRecord::Base
  scope :user_xx, -> (user_id) { where user_id: current_user.id }
  #scope :location, -> (location_id) { where location_id: location_id }
  #scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
end