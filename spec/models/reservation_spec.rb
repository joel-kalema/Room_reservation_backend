require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject do
    @user = User.create(name: 'Rida', email: 'example@mail.com', password: 'password', id: 1)
    @room = room.create(name: 'BMW', description: 'blue', price: 15, reserved: true, image: 'url', user_id: 1, id: 1)
    @reservation = Reservation.new(city: 'LA', duration: 12, date_reserved: '12-12-2021', room_id: 1, user_id: 1)
  end
  before { subject.save }

  it 'City name should not be nil' do
    subject.city = nil
    expect(subject).to_not be_valid
  end

  it 'Duration should not be nil' do
    subject.duration = nil
    expect(subject).to_not be_valid
  end

  it 'date_reserved should not be nil' do
    subject.date_reserved = nil
    expect(subject).to_not be_valid
  end
end
