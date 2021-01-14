class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :user_id
    validates :post_id, uniqueness: { scope: :user }
  end
end
