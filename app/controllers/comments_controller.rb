class CommentsController < ApplicationController
  before_action :load_event, only: %i[create destroy]
  before_action :load_comment, only: :destroy

  def create
    @comment = @event.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      notify_subscribers(@event, @comment)
      redirect_to @event, notice: I18n.t('controllers.comments.created')
    else
      render 'events/show', alert: I18n.t('controllers.comments.error')
    end
  end

  def destroy
    if current_user_can_edit?(@comment)
      message = { notice: I18n.t('controllers.comments.destroyed') }
      @comment.destroy
    else
      message = { alert: I18n.t('controllers.comments.error') }
    end
    redirect_to @event, message
  end

  private

  def load_event
    @event = Event.find(params[:event_id])
  end

  def load_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    (event.subscriptions.map(&:user_email) - [current_user&.email])
      .uniq
      .each do |mail|
      EventMailer.comment(event, comment, mail).deliver_later
    end
  end
end
