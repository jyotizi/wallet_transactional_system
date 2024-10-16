require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, password: 'password123') }

  describe 'POST #create' do
    context 'with valid credentials' do
      it 'signs in the user and returns success message' do
        post :create, params: { email: user.email, password: 'password123' }

        expect(response).to have_http_status(:ok)
      expect(json_response['message']).to eq('Loged in successfully!')
        expect(session[:user_id]).to eq(user.id)
        expect(json_response['data']['user_id']).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized status and error message' do
        post :create, params: { email: user.email, password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)
        expect(json_response['message']).to eq('Invalid email or password')
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = user.id
    end

    it 'logs the user out and clears the session' do
      delete :destroy, params: {}

      expect(response).to have_http_status(:ok)
      expect(json_response['message']).to eq('Loged out successfully!')
      expect(session[:user_id]).to be_nil
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
