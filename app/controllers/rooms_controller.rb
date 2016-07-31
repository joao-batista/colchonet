class RoomsController < ApplicationController
  PER_PAGE = 2

  before_action :set_users_room, only: [:edit, :update, :destroy]
  before_filter :require_authentication, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @search_query = params[:q]
    rooms = Room.search(@search_query).page(params[:page]).per(PER_PAGE)
    @rooms = RoomCollectionPresenter.new(rooms.most_recent, self) 


    #@rooms = rooms.most_recent.map do |room|
    #  RoomPresenter.new(room, self, false)
    #end
  end

  def show
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created') 
    else
      render :new 
    end
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated') 
    else
      render :edit 
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url, notice: t('flash.notice.room_destroyed') 
  end

  private
    def set_room
      @room = Rooms.find(params[:id])
    end

    def set_users_room
      @room = current_user.rooms.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:title, :location, :description, :picture)
    end
end
