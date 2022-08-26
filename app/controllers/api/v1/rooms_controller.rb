class Api::V1::RoomsController < ApplicationController
  before_action :set_room, only: %i[show update destroy]
  before_action :admin, only: %i[create update destroy]

  def index
    room = Room.all
    render json: room, status: 200
  end

  def show
    @room = room.find(params[:id])
    render json: JSON.pretty_generate(@room.as_json, except: :pictures)
  end

  def create
    room = room.new(room_params)
    room.user_id = @user.id
    if room.save
      render json: room
    elsif room.errors.messages
      render json: { errors: room.errors.messages }
    else
      render json: { error: 'room could not be created.' }
    end
  end

  def update
    if @room.update(room_params)
      render json: JSON.pretty_generate(@room.as_json)
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      render json: { message: 'room has been successfully deleted' }
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room
    @room = room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :description, :price, :pictures, :reserved)
  end

  def admin
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded_token = JWT.decode header, jwt_key, false, { algorithm: 'HS256' }
    @user = User.find(decoded_token[0]['user_id'])
    if @user.role == 'admin'
      @user
    else
      render json: { message: 'You do not have access to this resourse' }
    end
  end
end
