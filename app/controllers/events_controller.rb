class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user_event, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    
    if @event.save
      redirect_to @event
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    
    @event.destroy
    redirect_to user_path(@event.user)
  end
  
  private
  
  #Strong Parameter
  def event_params
    params.require(:event).permit(:title, :place, :price, :detail, :image, :kind, :genre, :prefecture, :start_time, :finish_time)
  end
  
  #本人の投稿か確認する
  def correct_user_event
    @event = Event.find(params[:id])
    redirect_to current_user unless current_user.id == @event.user_id
  end
  
end
