class SubscriptionsController < ApplicationController
  before_action :load_event, only: %i[create destroy]
  before_action :load_subscription, only: [:destroy]

  def create
    @subscription = @event.subscriptions.build(subscription_params)
    @subscription.user = current_user

    if @subscription.save
      EventMailer.subscription(@event, @subscription).deliver_now
      redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
    else
      render 'events/show', alert: I18n.t('controllers.subscriptions.error')
    end
  end

  def destroy
    if current_user_can_edit?(@subscription)
      message = { notice: I18n.t('controllers.subscriptions.destroyed') }
      @subscription.destroy
    else
      message = { alert: I18n.t('controllers.subscriptions.error') }
    end
    redirect_to @event, message
  end

  private

  def load_subscription
    @subscription = @event.subscriptions.find(params[:id])
  end

  def load_event
    @event = Event.find(params[:event_id])
  end

  def subscription_params
    params.fetch(:subscription, {}).permit(:user_email, :user_name)
  end
end
