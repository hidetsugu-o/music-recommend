class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:line]
  # :validatable

  self.primary_key = :user_id

  with_options presence: true do
    validates :user_id, uniqueness: { case_sensitive: true }
    validates :name
    validates :password
  end

  has_many :posts
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def self.from_omniauth(auth)
    pass = Devise.friendly_token
    User.where(user_id: auth.uid).first_or_create(
      user_id: auth.uid,
      name: auth.info.name,
      icon: auth.info.image,
      message: auth.info.description,
      password: pass,
      password_confirmation: pass
    )
  end
end
