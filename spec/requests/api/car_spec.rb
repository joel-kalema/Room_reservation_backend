require 'swagger_helper'
require 'rails_helper'
describe 'roomsEndpoints' do
  path '/api/v1/rooms' do
    get '/api/v1/rooms' do
      tags 'rooms'
      produces 'application/json'
      response '200', 'Get rooms' do
        User.create(name: 'user', email: 'user@dev.co', password: '123456', id: 1)
        room.create(name: 'BMW', description: 'blue', price: 15, reserved: true, user_id: 1)
        run_test!
      end
      response '200', 'Get rooms' do
        run_test! do |_response|
          expect(json.size).to eq 1
        end
      end
    end
  end
  path '/api/v1/rooms/{id}' do
    get '/api/v1/rooms/{id}' do
      tags 'rooms'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, required: true
      response '200', 'Get room detail' do
        room.create(name: 'Jeep', description: 'blue', price: 15, reserved: true, user_id: 1, id: 1)
        let(:id) { '1' }
        run_test!
      end
      response '200', 'Get rooms' do
        let(:id) { '1' }
        run_test! do |_response|
          expect(json['name']).to eq 'Jeep'
        end
      end
    end
  end
  path '/api/v1/rooms' do
    post '/api/v1/rooms' do
      tags 'rooms'
      produces 'application/json'
      parameter name: :Authorization, in: :header, type: :string, required: true
      parameter name: :room, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          reserved: { type: :boolean },
          description: { type: :string },
          price: { type: :decimal }
        },
        required: %w[name description price]
      }
      response '200', 'Get rooms' do
        @user = User.create!(id: 2, name: 'Rida', email: 'example@mail.com', password: 'password', role: 'admin')
        let(:Authorization) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc' }
        let(:room) do
          {
            name: 'Renault',
            description: 'blue',
            price: 15,
            user_id: 2
          }
        end
        run_test!
      end
      response '200', 'Create a nw room for not authorized user' do
        let(:Authorization) { 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.Ge9PnbYXkEn78GM4luhDfg9Y8NTsIkDv-zHhjSRBSPc' }
        let(:room) do
          {
            name: 'Renault',
            description: 'blue',
            price: 15,
            user_id: 2
          }
        end
        run_test! do |_response|
          expect(json['message']).to eq 'You do not have access to this resourse'
        end
      end
    end
  end
end
