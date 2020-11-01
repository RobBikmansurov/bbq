class EventNotifyJob < ApplicationJob
  queue_as :default

  def perform(model)
    event = model.event
    mails = (event.subscriptions.map(&:user_email) + [event.user.email] - [model.user&.email]).uniq
    case model
    when  Comment
      mails.each { |mail| EventMailer.comment(event, model, mail).deliver_later }
    when  Photo
      mails.each { |mail| EventMailer.photo(event, model, mail).deliver_later }
    end
  end
end
