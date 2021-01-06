class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :video_id, null: false
      t.string :user_id, null: false
      t.timestamps
    end
    add_foreign_key :posts, :users, column: :user_id, primary_key: :user_id 
  end
end
