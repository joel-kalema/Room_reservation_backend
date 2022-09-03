class Api::V1::RoomsController < ApplicationController
  before_action :set_room, only: %i[destroy show]

  def index
    @rooms = Room.all
  end

  def create
    @room = current_user.rooms.new(room_params)

    if @room.save!
      render :create, status: :created
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      render json: { message: 'Room has been successfully deleted' }
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :city, :rate, :room_type, :amenities, :picture, :user_id, :price)
  end
end
