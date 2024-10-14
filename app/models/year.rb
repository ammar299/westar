class Year < ApplicationRecord
  belongs_to :model
  has_many :parts
end