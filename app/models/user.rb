class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :comments
  has_one_attached :image
  attr_accessor :current_password # user_editpasswordなしで更新に必要?

  validates :nickname,       presence: true, length: { maximum: 10 }

  validates :full_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :full_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  validates :email,          presence: true, format: { with: /@+/ }

  # PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}/i.freeze
  # validates :password, format: { with: PASSWORD_REGEX }
end
