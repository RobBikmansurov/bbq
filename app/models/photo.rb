class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :photo, presence: true

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> { where.not(id: nil) }

end
