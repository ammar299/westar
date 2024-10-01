class PaymentsController < ApplicationController
  def new
  end

  def create
    token = params[:stripeToken]
    charge = Stripe::Charge.create(
      amount: 5000, # Amount in cents (e.g., $50.00)
      currency: 'usd',
      source: token,
      description: 'Payment for services'
    )

    redirect_to success_path # Redirect to a success page
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
