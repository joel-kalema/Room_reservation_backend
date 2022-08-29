require 'rails_helper'

RSpec.describe 'rooms', type: :request do
  before do
    @user = User.create!(id: 1, name: 'Rida', email: 'example@mail.com', password: 'password')
    room.create!(name: 'BMW', description: 'blue', price: 15, reserved: true, image: 'url', user_id: 1, id: 1)
    room.create!(name: 'Jeep', description: 'black', price: 20, reserved: false, image: 'url', user_id: 1, id: 2)
  end

  describe 'GET /rooms' do
    it 'Get list of rooms: test the size' do
      get '/api/v1/rooms'
      expect(json.size).to eq 2
    end

    it 'Return the room name' do
      get '/api/v1/rooms'
      room = json[0]
      expect(room['name']).to eq 'BMW'
    end

    it 'Return the room description' do
      get '/api/v1/rooms'
      room = json[1]
      expect(room['description']).to eq 'black'
    end

    it 'Returns status code 200' do
      get '/api/v1/rooms'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /rooms/:id' do
    before do
      get '/api/v1/rooms/1'
    end

    it 'Get the room details: test the size' do
      expect(json.size).to eq 9
    end

    it 'Return the room name' do
      expect(json['name']).to eq 'BMW'
    end

    it 'Return the room description' do
      expect(json['description']).to eq 'blue'
    end

    it 'Return the room price' do
      expect(json['price']).to eq '15.0'
    end

    it 'Return the room reserved' do
      expect(json['reserved']).to eq true
    end
  end

  describe 'POST /rooms' do
    context 'Not authorized user' do
      before do
        post '/api/v1/rooms/', params: {
                                 room: {
                                   name: 'Renault',
                                   description: 'blue',
                                   price: 15,
                                   image: 'url',
                                   user_id: 1
                                 }
                               },
                               headers: {
                                 Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc'
                               }
      end

      it ' Creat a new room test (not authorized)' do
        expect(json.size).to eq 1
      end

      it 'Get the not authorized message' do
        expect(json['message']).to eq 'You do not have access to this resourse'
      end
    end

    context 'Authorized user' do
      before do
        @user = User.create!(id: 2, name: 'user admin', email: 'user@mail.com', password: 'password', role: 'admin')
        post '/api/v1/rooms/', params: {
                                 room: {
                                   name: 'Renault',
                                   description: 'blue',
                                   price: 15,
                                   image: 'url',
                                   user_id: 1
                                 }
                               },
                               headers: {
                                 Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.NSblJ-t1wVTJ4U9dOYKrL3ZMe5ksjT_xFWZlxv1jIsM'
                               }
      end

      it ' Create a new room test (not authorized)' do
        expect(json.size).to eq 9
      end

      it 'Returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'Return the room name' do
        expect(json['name']).to eq 'Renault'
      end

      it 'Return the room description' do
        expect(json['description']).to eq 'blue'
      end

      it 'Return the room price' do
        expect(json['price']).to eq '15.0'
      end
    end
  end

  describe 'DELETE /rooms' do
    context 'Authorized user' do
      before do
        @user = User.create!(id: 2, name: 'user admin', email: 'user@mail.com', password: 'password', role: 'admin')
        delete '/api/v1/rooms/1',
               headers: {
                 Authorization: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.NSblJ-t1wVTJ4U9dOYKrL3ZMe5ksjT_xFWZlxv1jIsM'
               }
      end

      it ' Return success message' do
        expect(json['message']).to eq 'room has been successfully deleted'
      end
    end
  end
end
