class SubscriptionCheckoutController < ApplicationController

  def create

     @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
        line_items: [{
          quantity: 1,
          price: params[:id]
        }],
        success_url: authenticated_root_url,
        cancel_url: authenticated_root_url,
      })
    respond_to do |format|
      format.js
    end
  end
  def index
    @plans = Stripe::Price.list(lookup_keys: ['gold_year','gold_month'], expand: ["data.product"])
  end

  def destroy
    deleted_subscription = Stripe::Subscription.delete(params[:id])
    sleep(1.seconds)
    # redirect_back(fallback_location: authenticated_root_url)
    redirect_to authenticated_root_url
    # puts "deleted object : #{deleted_subscription}"
    # flash[:success] = "successfully updated"
    # render 'users/index' and return
    # respond_to do |format|
    #   # if deleted_subscription
    #   #   format.html { render 'subscription_checkout/edit', status: :unprocessable_entity }
    #   # else
    #     format.html { redirect_to authenticated_root_url, flash: { success: 'Successfully Unsubscribed and Status Updated.' } }
    #   # end
    # end

  end

end
