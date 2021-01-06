class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :omniauthable, omniauth_providers: [:line]
       # :validatable
          

  def self.from_omniauth(auth)
    pass = Devise.friendly_token
    user = User.where(user_id: auth.uid).first_or_create(
      user_id: auth.uid,
      user_name: auth.info.name,
      user_icon: auth.info.image,
      user_message: auth.info.description,
      password: pass,
      password_confirmation: pass,
    )
  end

end
