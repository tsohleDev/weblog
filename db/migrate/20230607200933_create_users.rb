class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 30, null: false # 30 max chars and not null
      t.string :photo
      t.text :bio
      t.integer :posts_counter, default: 0 # default value

      t.timestamps
    end
  end
end
