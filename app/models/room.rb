class Room < ApplicationRecord
  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :messages, dependent: :destroy
  has_one_attached :image, dependent: :destroy
end
