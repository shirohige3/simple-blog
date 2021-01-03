class MessagesController < ApplicationController

  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
     #roomに紐つくmessagesを全て定義。user情報も追加。
  end
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user) #投稿に失敗しても@messageの情報を保持したままにできる。
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:message_text, :image).merge(user_id: current_user.id)
  end

end
