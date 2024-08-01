class Part < ApplicationRecord
  validates :item_part_number, presence: true
  validates :part_number, presence: true
end