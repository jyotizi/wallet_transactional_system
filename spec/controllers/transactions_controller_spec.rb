require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:wallet) { create(:wallet) }
  let(:user) { create(:user, wallet: wallet) }
  let(:valid_attributes) { { walletable_type: 'User', walletable_id: user.id, transaction_type: 'credit', amount: 100 } }
  let(:invalid_attributes) { { walletable_type: 'User', walletable_id: user.id, transaction_type: 'credit', amount: -50 } }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new transaction' do
        expect {
          post :create, params: valid_attributes
        }.to change(Transaction, :count).by(1)
      end

      it 'returns a success message' do
        post :create, params: valid_attributes
        expect(JSON.parse(response.body)).to include("message" => "Transaction successful Created")
      end

      it 'returns a status of :created' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a transaction' do
        expect {
          post :create, params: invalid_attributes
        }.to change(Transaction, :count).by(0)
      end

      it 'returns error messages' do
        post :create, params: invalid_attributes
        expect(JSON.parse(response.body)).to include("errors" => ["Amount must be greater than 0"])
      end

      it 'returns a status of :unprocessable_entity' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'with an invalid transaction type' do
      it 'raises an ArgumentError' do
        expect {
          post :create, params: { walletable_type: 'User', walletable_id: user.id, transaction_type: 'invalid', amount: 100 }
        }.to raise_error(ArgumentError, "Invalid transaction type")
      end
    end
  end
end
