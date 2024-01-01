class RoomsController < ApplicationController
  before_action :set_room, only: [:show]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # POST /rooms
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to @room, notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def room_params
    params.require(:room).permit(:name)
  end
end
