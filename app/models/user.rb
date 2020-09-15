class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_validation :rand_name, on: :create
  after_commit :link_subscriptions, on: :create

  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 35 }

  private

  def rand_name
    self.name = "Товарисч #{rand(1000)}"
  end

  # обновить подписки, если юзер сначала подписался, а потом зарегистрировался
  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email)
                .update_all(user_id: id)
  end
end
