class CheckoutController < ApplicationController
  def create
    bug=Bug.find(params[:id].to_i)
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: bug.bug_price.to_i,
          product_data: {
            name: bug.title
          },
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: bugs_url(status: "assigned"),
      cancel_url: bugs_url(status: "assigned"),
    })
    respond_to do |format|
      format.js
    end
  end

end
