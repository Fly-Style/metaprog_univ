class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.text :address
      t.text :comment
      t.integer :status

      t.timestamps null: false
    end
  end
end
