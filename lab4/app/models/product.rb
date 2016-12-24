class Product < ActiveRecord::Base
  searchable do
      integer :category_id
      string :name
      string :img
      text :desc_short
      text :desc_long
  end
end
