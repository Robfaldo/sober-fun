class EventsController < ApplicationController
  def index
    params[:tag] ? @events = Event.tagged_with(params[:tag]) : @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_index_path
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :time, :date, :location, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end
