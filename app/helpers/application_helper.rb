module ApplicationHelper
  def user_avatar(_user)
    'user.png'
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
end
