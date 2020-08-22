class Room < ApplicationRecord
  has_many :room_users
  has_many :room_users, through: :room_users 
end
