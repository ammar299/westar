class Part < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  
  has_many_attached :images

  validates :item_part_number, presence: true
  validates :part_number, presence: true

end