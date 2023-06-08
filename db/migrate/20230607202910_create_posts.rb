class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, limit: 225, null: false # 255 max chars
      t.text :text, null: false
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0
      t.references :author, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
