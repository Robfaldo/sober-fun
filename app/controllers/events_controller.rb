class EventsController < ApplicationController
  def index
    params[:tag] ? @events = Event.tagged_with(params[:tag]) : @events = Event.all
    @tags = Tag.all
    @price_filters = ['free', 'under10', 'ten_to_thirty']
  end

  def show
    @event = Event.find(params[:id])
  end

  def search
    # TODO: use strong params for the price_filters (too tired but NEED to do it)
    @events = Event.price_filter(params[:price_filters])
    render html: @events
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
    params.require(:event).permit(:title, :price, :description, :time, :date, :location, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  end
end
