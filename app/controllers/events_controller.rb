class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_index_path
  end

  def create
    @event = current_user.events.build(event_params)
    @event.save

    redirect_to @event
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :time, :date, :location)
  end
end
