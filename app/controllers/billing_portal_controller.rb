class BillingPortalController < ApplicationController
  def create
   billing_session = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: authenticated_root_url,
    })

    redirect_to billing_session.url
  end
end
