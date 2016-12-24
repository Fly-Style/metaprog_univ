class CreateRidings < ActiveRecord::Migration
  def change
    create_table :ridings do |t|
      t.string :name
      t.float :first
      t.float :second
      t.integer :winner
      t.boolean :visible
      t.boolean :active

      t.timestamps null: false
    end
  end
end
