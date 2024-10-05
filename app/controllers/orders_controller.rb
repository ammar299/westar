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
    # Initialize a new order
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

    # Proceed to create the order and charge only if there are no validation errors
    if @order.valid?
      begin
        token = params[:stripeToken]
        charge = Stripe::Charge.create(
          amount: (@order.total_amount * 100).to_i, # Amount in cents
          currency: 'usd',
          source: token,
          description: 'Payment for services'
        )

        # If charge is successful, save the order
        if @order.save
          session[:cart] = nil # Clear the cart session
          redirect_to @order, notice: 'Order was successfully created.'
        else
          flash[:error] = @order.errors.full_messages.join(", ")
          redirect_to new_order_path # Redirect back to the new order page
        end
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_order_path # Redirect back to the new order page
      end
    else
      flash[:error] = @order.errors.full_messages.join(", ")
      redirect_to new_order_path # Redirect back to the new order page
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
      :phone, :date, :total_parts, :active, :status, :user_id, :total_amount, 
      order_items_attributes: [:id, :part_id, :quantity, :_destroy]
    )
  end
end