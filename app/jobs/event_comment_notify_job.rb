class EventCommentNotifyJob < ApplicationJob
  queue_as :default

  def perform(event, comment)
    (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user&.email])
      .uniq
      .each do |mail|
        EventMailer.comment(event, comment, mail).deliver_later
      end
  end
end
