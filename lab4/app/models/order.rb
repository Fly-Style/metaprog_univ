class Order < ActiveRecord::Base
  has_many :order_positions
end
