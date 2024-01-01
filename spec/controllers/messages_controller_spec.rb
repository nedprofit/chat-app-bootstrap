require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:valid_attributes) { { content: 'Hello World' } }
  let(:invalid_attributes) { { content: '' } }

  before do
    sign_in user
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new Message and redirects to the Room' do
        expect {
          post :create, params: { room_id: room.id, message: valid_attributes }, format: :turbo_stream
        }.to change(Message, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'does not create a new Message and redirects back to the Room' do
        expect {
          post :create, params: { room_id: room.id, message: invalid_attributes }, format: :turbo_stream
        }.not_to change(Message, :count)

        expect(response).to redirect_to(room)
      end
    end
  end

  describe '#show' do
    let(:message) { create(:message, room: room, user: user) }

    it 'returns a success response' do
      get :show, params: { room_id: room.id, id: message.id }
      expect(response).to be_successful
    end
  end
end
