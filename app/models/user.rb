class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :rand_name, on: :create
  after_commit :link_subscriptions, on: :create

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 35 }

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

