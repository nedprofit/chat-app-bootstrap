require 'rails_helper'

RSpec.describe Room, type: :model do
  describe '#name' do
    it 'validates presence' do
      room = Room.new(name: '')
      expect(room.valid?).to be_falsey
    end
  end
end
