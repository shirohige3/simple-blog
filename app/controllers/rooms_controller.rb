class RoomsController < ApplicationController
#   before_action :create, only: %i[index]

#   def index
#     @user = User.find(params[:user_id])
#     @rooms = Room.includes(:user)
#   end

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
  end

#     private

#     def room_params
#       params.require(:room).permit(:name, :user_ids[]).merge(user_id: @user.id)
#     end
# end

 
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
