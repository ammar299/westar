module OrdersHelper
  def order_status_class(status)
    case status
    when 'pending'
      'badge-warning'
    when 'processing'
      'badge-info'
    when 'shipped'
      'badge-primary'
    when 'delivered'
      'badge-success'
    else
      'badge-secondary'
    end
  end
end
