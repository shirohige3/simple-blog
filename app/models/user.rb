class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs
  has_many :comments
  has_one_attached :image
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  
  attr_accessor :current_password # user_editpasswordなしで更新に必要?

  validates :nickname,       presence: true, length: { maximum: 10 }
  validates :full_name,      presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ }
  validates :full_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email,          presence: true, format: { with: /@+/ }

  validate :password_complexity
  
  def password_complexity
    return if password.blank? || password =~ /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z{6,}$/
    errors.add :password, 'は半角英数字で6文字以上で入力してください。'
  end

  #ゲストログイン用
  def self.guest
    User.find_or_create_by(nickname: "ゲスト", full_name: "ゲスト", full_name_kana: "ゲスト", email: 'guest@example.com') do |user|
      user.id = 0
      user.nickname = "ゲスト"
      user.full_name = "ゲスト"
      user.full_name_kana = "ゲスト"
      user.encrypted_password = SecureRandom.urlsafe_base64
    end
  end

  # ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_user.include?(user)
end

end
