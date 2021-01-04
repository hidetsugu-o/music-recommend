class Post < ApplicationRecord
  validates :link, presence: true

  def self.get_id
    posts = Post.order('created_at DESC')
    ids = []
    
    posts.each do |post|
      url = post.link
      if url.include?("=")
        url.slice!("https://www.youtube.com/watch?v=")
      else
        url.slice!("https://youtu.be/")
      end
      ids.push(url)
    end

    return ids
  end
end
