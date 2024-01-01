class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = @room.messages.new(message_params.merge(user: current_user))

    if @message.save
      respond_to do |format|
        format.turbo_stream do
          @message.broadcast_append_to "chat_#{@room.id}",
                                       target: "messages_chat_#{@room.id}",
                                       partial: "messages/message",
                                       locals: { message: @message, broadcast: true }
        end
        format.html { redirect_to @room }
      end
    else
      redirect_to @room, alert: 'Unable to send message.'
    end
  end

  def show
    @user = current_user
    @message = Message.find(params[:id])

    respond_to do |format|
      format.turbo_stream { render partial: 'messages/message', locals: { message: @message, user: @user } }
      format.html { render partial: 'messages/message', locals: { message: @message, user: @user } }
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
