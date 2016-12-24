class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.float :value
      t.float :potentialWin
      t.boolean :sucessful
      t.boolean :active
      t.belongs_to :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
