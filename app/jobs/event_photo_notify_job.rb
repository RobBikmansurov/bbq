class EventPhotoNotifyJob < ApplicationJob
  queue_as :default

  def perform(event, photo)
    (event.subscriptions.map(&:user_email) + [event.user.email] - [photo.user&.email])
      .uniq
      .each do |mail|
        EventMailer.photo(event, photo, mail).deliver_later
      end
  end
end
