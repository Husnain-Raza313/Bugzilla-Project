class PaymentIntentsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    bug=Bug.find(params[:id].to_i)
    begin
      paymentIntent= Stripe::PaymentIntent.create(
        {
          amount: bug.bug_price.to_i,
          currency: 'usd'
        },
      )
      render json: paymentIntent
    rescue Stripe::StripeError => e
      puts "Another problem occurred, maybe unrelated to Stripe. #{e.error.message}"
      render json: e.error
    end
  end
end
