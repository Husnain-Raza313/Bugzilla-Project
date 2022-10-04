class PaymentIntentsController < ActionController::API
  def create
    puts "HELLO IM IN CREATE"
    paymentIntent= Stripe::PaymentIntent.create(
      {
        amount: 1099,
        currency: 'usd',
      },
    )
    render json: paymentIntent
  end
end
