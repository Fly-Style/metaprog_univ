class OrderPosition < ActiveRecord::Migration
  def change
    create_table :order_positions do |t|
      t.integer :product_id
      t.integer :order_id
      t.decimal :price

    end
  end
end
