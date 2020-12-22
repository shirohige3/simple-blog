class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message_text,  presence: true
end
