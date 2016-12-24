class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :short_text
      t.text :long_text
      t.string :img

      t.timestamps null: false
    end
  end
end
