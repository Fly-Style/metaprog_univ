class CreateBetToRides < ActiveRecord::Migration
  def change
    create_table :bet_to_rides do |t|
      t.integer :bet_winner
      t.boolean :success
      t.belongs_to :riding, index: true, foreign_key: true
      t.belongs_to :bet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
