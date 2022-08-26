require 'rails_helper'

RSpec.describe 'Reservations', type: :request do
  before do
    @user = User.create!(id: 1, name: 'Rida', email: 'example@mail.com', password: 'password')
    @room = room.create!(name: 'BMW', description: 'blue', price: 15, reserved: true, image: 'url', user_id: 1, id: 1)
    @reservation = Reservation.create(city: 'LA', duration: 12, date_reserved: '12-12-2021', room_id: 1, user_id: 1)
  end

  describe 'GET /reservations' do
    before do
      get '/api/v1/reservations/',
          headers: {
            Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc'
          }
    end

    it 'Returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'Get list of reservation: test the size' do
      expect(json.size).to eq 1
    end

    it 'Return the city name' do
      reservation = json[0]
      expect(reservation['city']).to eq @reservation.city
    end

    it 'Return the duration' do
      reservation = json[0]
      expect(reservation['duration']).to eq @reservation.duration
    end

    it 'Return the date_reserved' do
      reservation = json[0]
      expect(reservation['date_reserved']).to eq '2021-12-12'
    end
  end

  describe 'POST /reservations' do
    context 'Successfully created' do
      before :each do
        post '/api/v1/reservations/', params: {
          reservation: {
            city: 'Rabat',
            duration: 12,
            date_reserved: '12-05-2022',
            user_id: 1,
            room_id: 1
          }
        },
                                      headers: {
                                        Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc'
                                      }
      end

      it 'Returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'Return the city name' do
        expect(json['city']).to eq 'Rabat'
      end

      it 'Get list of reservation: test the size' do
        expect(json.size).to eq 7
      end
    end

    context 'Creating reservation failed' do
      before :each do
        post '/api/v1/reservations/', params: {
          reservation: {
            city: nil,
            duration: 12,
            date_reserved: '12-05-2022',
            user_id: 1,
            room_id: 1
          }
        },
                                      headers: {
                                        Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc'
                                      }
      end

      it 'Returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'Returns erroes message' do
        expect(json['errors']).to eq 'Reservation not created'
      end
    end
  end
end
