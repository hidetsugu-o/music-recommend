class Post < ApplicationRecord
  with_options presence: true do
    validates :video_id
    validates :user_id
  end

  belongs_to :user, primary_key: :user_id
end
