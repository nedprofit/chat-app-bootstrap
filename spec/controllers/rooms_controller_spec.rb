require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let(:user) { create(:user) }
  let(:room) { create(:room) }
  let(:valid_attributes) { { name: 'Chat Room' } }
  let(:invalid_attributes) { { name: '' } }

  before do
    sign_in user
  end

  describe '#index' do
    it 'returns a success response' do
      Room.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe '#show' do
    it 'returns a success response' do
      room = Room.create! valid_attributes
      get :show, params: { id: room.to_param }
      expect(response).to be_successful
    end
  end

  describe '#new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new Room' do
        expect {
          post :create, params: { room: valid_attributes }
        }.to change(Room, :count).by(1)
      end

      it 'redirects to the created room' do
        post :create, params: { room: valid_attributes }
        expect(response).to redirect_to(Room.last)
      end
    end

    context 'with invalid params' do
      it 'Room is not created' do
        expect {
          post :create, params: { room: invalid_attributes }
        }.to change(Room, :count).by(0)
      end
    end
  end
end
