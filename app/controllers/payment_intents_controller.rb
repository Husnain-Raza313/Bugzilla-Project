class PaymentIntentsController < ActionController::API
  def create
    bug=Bug.find(params[:id].to_i)
    paymentIntent= Stripe::PaymentIntent.create(
      {
        amount: bug.bug_price.to_i,
        currency: 'usd',
      },
    )
    render json: paymentIntent
  end
end
