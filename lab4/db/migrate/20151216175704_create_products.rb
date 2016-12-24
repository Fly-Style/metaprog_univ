class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :name
      t.string :img
      t.text :desc_short
      t.text :desc_long

      t.timestamps null: false
    end
  end
end
