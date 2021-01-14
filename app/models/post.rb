class Post < ApplicationRecord
  with_options presence: true do
    VIDEO_ID_REGEX = /\A[a-z\d\-_]{11,11}\z/i.freeze
    validates :video_id, format: { with: VIDEO_ID_REGEX, message: "は登録できない値です" }
  end

  belongs_to :user, primary_key: :user_id
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def include_youtube?
    str = self.video_id
    if str.include?('youtube.com/watch?v=') || str.include?('youtu.be/') || str.include?('youtube.com/embed/')
      self.video_id = str.scan(/[a-z\d\-_]{11,11}/i)[0]
    else
      return false
    end
  end
  
end
