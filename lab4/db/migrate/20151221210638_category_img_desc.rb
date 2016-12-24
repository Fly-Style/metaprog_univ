class CategoryImgDesc < ActiveRecord::Migration
  def change
    add_column :categories, :img, :string
    add_column :categories, :desc, :text
  end
end
