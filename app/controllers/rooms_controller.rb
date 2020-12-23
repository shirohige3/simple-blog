class RoomsController < ApplicationController
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_messages_path(@room)
    else
      render :new
    end

    private

    def room_params
      params.require(:room).permit(:user_ids: [])
    end
end
