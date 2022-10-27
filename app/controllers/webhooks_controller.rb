class WebhooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil
    if !Webhook.find_by(source: 'stripe', external_id: params[:id]).nil?
      render json: { message: "Already Processed #{payload.id}"}
      return
    end

    Webhook.create(webhook_params)
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials.dig(:stripe, :webhook).to_s
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      return
    end

    case event.type
    when 'checkout.session.completed'
     if event.data.object.mode === "subscription"
      session = event.data.object
      @user = User.find_by(stripe_customer_id: session.customer)
      @user.update(
        subscription_status: 'active',
        subscription_id: session.subscription,
      )
     end
    when 'customer.subscription.updated', 'customer.subscription.deleted'
      subscription = event.data.object
      @user = User.find_by(stripe_customer_id: subscription.customer)
      @user.update(
        subscription_status: subscription.canceled_at ? 'Canceled' : subscription.status,
        plan: subscription.items.data[0].price.lookup_key,
      )
    end

    render json: { message: 'success' }
  end

  def webhook_params
    {
      source: 'stripe',
      data: params[:data],
      external_id: params[:id]

    }
  end
end
