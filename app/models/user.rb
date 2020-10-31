class User < ApplicationRecord
  EMPTY_EMAIL_PREFIX = 'change-me-'.freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  before_validation :rand_name, on: :create
  after_commit :link_subscriptions, on: :create

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 35 }
  validates :email, :name, uniqueness: true

  def self.find_for_oauth_provider(access_token)
    url, provider, email = oauth_parse(access_token)
    user = where(email: email).first
    return user if user.present?

    name = access_token.info.name
    user = where(name: name).first
    return user if user.present?

    user_from_oauth(url, provider, email, name, access_token.info.image)
  end

  def self.user_from_oauth(url, provider, email, name, avatar)
    where(url: url, provider: provider).first_or_create! do |user|
      user.remote_avatar_url = avatar
      user.email = email
      user.name = name
      user.password = Devise.friendly_token.first(16)
    end
  end

  def self.oauth_parse(access_token)
    email = access_token.info.email
    email ||= "#{EMPTY_EMAIL_PREFIX}#{access_token.info.first_name}@#{access_token.uid}.#{access_token.provider}.com"
    id = access_token.extra.raw_info.id
    provider = access_token.provider
    url = case provider
          when 'facebook' then "https://facebook.com/#{id}"
          when 'vkontakte' then access_token.info.urls.first[1]
          end
    [url, provider, email, name]
  end

  private

  def rand_name
    self.name = "Товарисч #{rand(1000)}" if name.blank?
  end

  # обновить подписки, если юзер сначала подписался, а потом зарегистрировался
  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end

