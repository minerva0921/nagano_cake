class OrderDetail < ApplicationRecord
  belongs_to :order
	belongs_to :item
	
	validates :item_id, :order_id, :order_quantity, :settlement_amount, presence: true
	validates :settlement_amount, :order_quantity, numericality: { only_integer: true }
	
	enum production_status: {"着手不可": 0,"製作待ち": 1,"製作中": 2,"製作完了": 3}
end
