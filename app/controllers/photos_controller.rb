class PhotosController < ApplicationController
  before_action :load_event, only: %i[create destroy]
  before_action :load_photo, only: [:destroy]

  def create
    @photo = @event.photos.build(photo_params)
    @photo.user = current_user

    if @photo.save # Если фотографию удалось сохранить, редирект на событие с сообщением
      EventNotifyJob.perform_later(@photo)
      redirect_to @event, notice: I18n.t('controllers.photos.created')
    else
      render 'events/show', alert: I18n.t('controllers.photos.error')
    end
  end

  def destroy
    message = { notice: I18n.t('controllers.photos.destroyed') }

    if current_user_can_edit?(@photo)
      @photo.destroy
    else
      message = { alert: I18n.t('controllers.photos.error') }
    end
    redirect_to @event, message
  end

  private

  def load_event
    @event = Event.find(params[:event_id])
  end

  def load_photo
    @photo = @event.photos.find(params[:id])
  end

  def photo_params
    params.fetch(:photo, {}).permit(:photo)
  end
end
