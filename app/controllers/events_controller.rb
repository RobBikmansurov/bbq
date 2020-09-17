class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :load_event, only: :show
  before_action :load_current_user_event, only: %i[edit update destroy]
  before_action :pincode_guard!, only: [:show]

  def index
    @events = Event.all
  end

  def show
    @comment = @event.comments.build(params[:comment])
    @subscription = @event.subscriptions.build(params[:subscription])
    @photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build(datetime: Time.zone.now)
  end

  def edit; end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def load_current_user_event
    @event = current_user.events.find(params[:id])
  end

  def load_event
    @event = Event.find(params[:id])
  end

  def event_params
    # params.fetch(:event, {})
    params.require(:event).permit(:title, :address, :datetime, :description, :user, :pincode)
  end

  def pincode_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    pincode = cookies.permanent["events_#{@event.id}_pincode"]
    return if @event.pincode_valid?(pincode)

    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'pincode_form'
  end
end
