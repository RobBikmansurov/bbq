class ApplicationController < ActionController::Base
  include Pundit

  helper_method :current_user_can_edit?
  helper_method :current_user_can_create?
  helper_method :current_user_already_subscribed?

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def configure_permitted_parameters
    attributes = %i[name email password password_confirmation current_password]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  def current_user_can_edit?(model)
    user_signed_in? && (
    model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
  )
  end

  def current_user_can_create?(model)
    return true unless user_signed_in?

    model.try(:event).present? && model.event.user != current_user
  end

  def current_user_already_subscribed?(model)
    event = model.try(:event)
    user_signed_in? && event.present? && event.subscriptions.where(user_id: current_user.id).any?
  end

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
