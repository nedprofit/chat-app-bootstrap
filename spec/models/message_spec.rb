require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#content' do
    it 'validates presence' do
      message = Message.new(content: '')
      expect(message.valid?).to be_falsey
    end
  end
end
