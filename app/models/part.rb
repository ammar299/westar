# app/models/part.rb
class Part < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :model
  belongs_to :year
  
  has_many_attached :images

  validates :item_part_number, presence: true
  validates :part_number, presence: true

  # Searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[
      item_part_number
      part_number
      name
      description
      package_level_gtin
      height
      width
      length
      shipping_height
      shipping_width
      shipping_length
      weight
      attribute_name
      price
      product_attribute
    ]
  end

  # Searchable associations
  def self.ransackable_associations(auth_object = nil)
    %w[order_items orders images_attachments images_blobs]
  end
end