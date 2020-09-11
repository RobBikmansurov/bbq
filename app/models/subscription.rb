class Subscription < ApplicationRecord
  REGEXP_EMAIL = /\A[\w\d._-]+@[\d\w.]+\.\w+\z/.freeze
  REGEXP_USERNAME = /\A[A-Za-z0-9_]+\z/.freeze

  belongs_to :user, optional: true
  belongs_to :event

  validates :event, presence: true
  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: REGEXP_EMAIL }, unless: -> { user.present? }
  # Для конкретного event_id один юзер может подписаться только один раз (если юзер задан)
  validates :user, uniqueness: { scope: :event_id }, if: -> { user.present? }
  # Или один email может использоваться только один раз (если анонимная подписка)
  validates :user_email, uniqueness: { scope: :event_id }, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end
end