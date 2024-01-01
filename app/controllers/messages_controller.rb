class MessagesController < ApplicationController
  before_action :set_room

  # POST /rooms/:room_id/messages
  def create
    @message = @room.messages.new(message_params.merge(user: current_user))

    if @message.save
      redirect_to @room, notice: 'Message was successfully sent.'
    else
      redirect_to @room, alert: 'Unable to send message.'
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
