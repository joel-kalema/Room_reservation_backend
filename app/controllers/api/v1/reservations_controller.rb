class Api::V1::ReservationsController < ApplicationController
  def index
    response = []
    header = request.headers['Authorization']
    header = header.split.last if header
    decoded_token = JWT.decode header, jwt_key, false, { algorithm: 'HS256' }
    data = decoded_token[0]['user_id']
    reservations = Reservation.where(user_id: data)

    reservations.each do |res|
      response << {
        id: res.id,
        city: res.city,
        duration: res.duration,
        date_reserved: res.date_reserved,
        user_id: res.user_id,
        room: roomSerializer.new(room.find(res.room_id))
      }
    end

    render json: response, status: 200
  end

  def create
    reservation = Reservation.new(reservation_params)
    response = {
      id: reservation.id,
      city: reservation.city,
      user_id: reservation.user_id,
      duration: reservation.duration,
      date_reserved: reservation.date_reserved,
      room: roomSerializer.new(room.find(reservation.room_id))
    }

    if reservation.save
      render json: response, status: 200
    else
      render json: { errors: 'Reservation not created' }, status: :unprocessable_entity
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :date_reserved, :duration, :city)
  end
end
