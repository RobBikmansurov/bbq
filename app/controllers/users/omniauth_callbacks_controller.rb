module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      from_provider
    end

    def vkontakte
      from_provider
    end

    private

    def from_provider
      @user = User.find_for_oauth_provider(request.env['omniauth.auth'])
      provider = request.env['omniauth.auth'].provider || 'omniauth'

      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
      else
        flash[:error] = I18n.t('devise.omniauth_callbacks.failure', kind: provider.capitalize, reason: 'authentication error')
        redirect_to root_path
      end
    end
  end
end
