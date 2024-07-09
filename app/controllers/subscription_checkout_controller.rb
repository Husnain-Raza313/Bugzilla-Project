class SubscriptionCheckoutController < ApplicationController

  def create

     @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: params[:id]
        }],
        success_url: view_projects_url(report: "success"),
        cancel_url: view_projects_url(report: "failed"),
      })
    respond_to do |format|
      format.js
    end
  end
  def index
    @plans = Stripe::Price.list(lookup_keys: ['gold_year','gold_month'], expand: ["data.product"])
  end

  def destroy
    deleted_subscription = Stripe::Subscription.cancel(params[:id])
    current_user.update(
      subscription_status: deleted_subscription.status,
    )
    redirect_to subscription_checkout_index_path , notice: "Successfully Unsubscribed and Refunded"


  end

end
