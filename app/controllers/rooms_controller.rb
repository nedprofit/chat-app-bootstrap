class RoomsController < ApplicationController
  before_action :set_room, only: [:show]

  def index
    @private_rooms = Room.joins(:room_participations).where(room_participations: { user_id: current_user.id }, private: true)
    @public_rooms = Room.where(private: false)
  end

  def show
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params.except(:participant_id))
    @room.participants << current_user

    if @room.private_room? && params[:room][:participant_id].present?
      participant = User.find(params[:room][:participant_id])
      @room.participants << participant if participant
    end

    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :private, :participant_id)
  end
end
