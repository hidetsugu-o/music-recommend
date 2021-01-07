class Post < ApplicationRecord
  with_options presence: true do
    validates :video_id
    validates :user_id
  end

  belongs_to :user, primary_key: :user_id
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
end
