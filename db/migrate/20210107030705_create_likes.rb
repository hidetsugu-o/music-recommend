class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.string :user_id,  null:false
      t.references :post, foreign_key: true
      t.timestamps
    end
    add_foreign_key :likes, :users, column: :user_id, primary_key: :user_id
  end
end
