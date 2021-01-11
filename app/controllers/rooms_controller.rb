class RoomsController < ApplicationController
  before_action :set_room, only: %i[show destroy] 

  def index
    @rooms = Room.includes(:user)
  end

  def new
    @room = Room.new
  end

  def create
    # @roomは既存のものがあればそのまま使用 first_or_initialize(保留)
    @room = Room.new(room_params)
    if @room.save
      # redirect_to room_path(@room)
      redirect_to room_messages_path(@room)
    else
      render :new
    end
  end

  def show
    binding.pry
    @message = Message.find(params[:id])
  end
 
   def destroy
     room.destroy
     redirect_to root_path
   end
 
   private
   def room_params
     params.require(:room).permit(:name, user_ids:[])
   end

   def set_room
    @room = Room.find(params[:id])
   end

 end
