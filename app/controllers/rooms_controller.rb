class RoomsController < ApplicationController
#   def index
#     @user = User.find(params[:user_id])
#     @rooms = Room.includes(:user)
#   end

  def new
    @room = Room.new
  end

  def create
    # @roomは既存のものがあればそのまま使用 first_or_initialize
    @room = Room.where(user_ids:[]).first_or_initialize
    if @room.save
      redirect_to room_messages_path(@room)
    else
      render :new
    end
  end
 
   def destroy
     room = Room.find(params[:id])
     room.destroy
     redirect_to root_path
   end
 
   private
   def room_params
     params.require(:room).permit(:name, user_ids:[])
   end
 end
