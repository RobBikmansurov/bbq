module ApplicationHelper
  def user_avatar(user)
    if user.avatar?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user.png')
    end
  end
end
