class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :username
      t.string :email
      t.string :password
      t.float :balance
      t.boolean :is_super
      t.boolean :is_book

      t.timestamps null: false
    end
  end
end
