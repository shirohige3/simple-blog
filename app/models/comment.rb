class Comment < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :blog, dependent: :destroy

  validates :text, presence: true
end
