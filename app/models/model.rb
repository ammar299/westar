class Model < ApplicationRecord
  belongs_to :make
  has_many :parts
  has_many :years
end