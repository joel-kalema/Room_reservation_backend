require 'rails_helper'

RSpec.describe room, type: :model do
  subject do
    @user = User.create(name: 'double', email: 'example@mail.com', password: 'password', id: 1)
    @room = room.new(name: 'single', description: 'selfcontained', price: 15, reserved: true, image: 'url', user_id: 1)
  end
  before { subject.save }

  it 'Name should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Description should not be nil' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'Price should not be nil' do
    subject.price = nil
    expect(subject).to_not be_valid
  end
end
