class SubscriptionCheckoutController < ApplicationController

  def create

    # @session = Stripe::Checkout::Session.create({
     @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: params[:id]
        }],
        success_url: bugs_url(status: "assigned"),
        cancel_url: bugs_url(status: "assigned"),
      })
    respond_to do |format|
      format.js
    end
  end

  def index
    @plans = Stripe::Price.list(lookup_keys: ['gold_year','gold_month'], expand: ["data.product"])
  end
end
