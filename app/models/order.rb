class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  has_many :parts, through: :order_items

  accepts_nested_attributes_for :order_items, allow_destroy: true
  
  enum status: { pending: 0, processing: 1, shipped: 2, delivered: 3 }

  scope :active, -> { where(active: true) }

  before_create :generate_order_number, :set_date_time_est
  

  
  def total_amount_order
    order_items.sum { |item| item.part.price * item.quantity }
  end

  private

  def generate_order_number
    self.order_number = "ORD#{created_at.strftime('%Y%m%d%H%M%S')}"
  end

  def set_date_time_est
    self.date = Time.now.in_time_zone('Eastern Time (US & Canada)')
  end

  def set_default_price
    self.price ||= 0.0
  end

end