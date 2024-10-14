class Make < ApplicationRecord
  has_many :models
  has_many :parts, through: :models
end