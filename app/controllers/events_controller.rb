class EventsController < ApplicationController
  def new
  end

  def create
    @event = Event.new(event_params)
    @event.save

    redirect_to @event
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :time, :date, :location)
  end
end
