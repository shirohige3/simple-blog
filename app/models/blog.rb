class Blog < ApplicationRecord
  has_many   :comments
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
  validates :title
  validates :text
  end
  
end
