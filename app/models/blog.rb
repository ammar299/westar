# app/models/blog.rb
class Blog < ApplicationRecord
  belongs_to :category
  has_one_attached :image  # Assuming you're using Active Storage for images
end