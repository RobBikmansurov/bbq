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
    user_signed_in? &&
      model.try(:event).present? &&
      model.event.user != current_user
  end
end
