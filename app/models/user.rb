class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:line]
       # :validatable

  self.primary_key = :user_id

  with_options presence: true do
    validates :user_id, uniqueness: true
    validates :name
    validates :password
  end

  has_many :posts

  def self.from_omniauth(auth)
    pass = Devise.friendly_token
    user = User.where(user_id: auth.uid).first_or_create(
      user_id: auth.uid,
      name: auth.info.name,
      icon: auth.info.image,
      message: auth.info.description,
      password: pass,
      password_confirmation: pass,
    )
  end

end
