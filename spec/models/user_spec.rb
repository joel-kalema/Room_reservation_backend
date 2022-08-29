require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(name: 'Rida', email: 'example@mail.com', password: 'password')
  end
  before { subject.save }

  it 'Name should not be nil' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Email should not be nil' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'Default role should be "subscriber"' do
    expect(subject.role).to eq 'subscriber'
  end
end
