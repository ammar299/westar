class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @part_items = @order.order_items
    @parts = @order.parts
  end

  def new
    @order = Order.new
    @parts = Part.where(id: session[:cart]&.uniq)

    session[:cart]&.uniq&.each do |part_id|
      @order.order_items.build(part_id: part_id, quantity: session[:cart].count(part_id))
    end

    Rails.logger.debug "session[:cart] = #{session[:cart]}"
  end

  def create
    @order = Order.new(order_params)

    # Initialize total amount and total parts
    @order.total_amount = 0
    @order.total_parts = 0

    # Loop through order items to calculate totals
    if params[:order][:order_items_attributes].present?
      params[:order][:order_items_attributes].each do |_, item_params|
        part = Part.find_by(id: item_params["part_id"].to_i)
        if part.present?
          # Build order items for the order
          order_item = @order.order_items.build(part: part, quantity: item_params["quantity"].to_i)
          
          # Accumulate total amount and parts
          @order.total_amount += part.price * order_item.quantity
          @order.total_parts += order_item.quantity
        else
          @order.errors.add(:base, "Invalid part ID: #{item_params['part_id']}")
        end
      end
    end

    # Save the order and handle errors
    if @order.errors.empty? && @order.save
      session[:cart] = nil
      session.delete(:cart)
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    @parts = @order.parts
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_path
  end

  private

 def order_params
    params.require(:order).permit(
      :order_id, :phone, :date, :total_parts, :active, :status, :user_id, :total_amount, 
      order_items_attributes: [:id, :part_id, :quantity, :_destroy]
    )
  end

end