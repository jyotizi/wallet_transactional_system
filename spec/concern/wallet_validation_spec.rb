require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:wallet) { create(:wallet) }
  let(:team) { create(:team, wallet: wallet) }
  let(:valid_params) do
    {
      walletable_type: 'Team',
      walletable_id: team.id,
      amount: 300,
      transaction_type: 'credit'
    }
  end

  describe 'before_action :validate_walletable_params' do
    context 'when walletable_type is invalid' do
      it 'renders an error message and halts execution' do
        post :create, params: valid_params.merge(walletable_type: 'InvalidType')

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq("Invalid walletable type. Allowed types are: User, Stock, Team.")
      end
    end

    context 'when transaction_type is invalid' do
      it 'renders an error message and halts execution' do
        post :create, params: valid_params.merge(transaction_type: 'invalid')

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq("Invalid transaction type. Allowed types are: credit, debit.")
      end
    end

    context 'when walletable_id is empty' do
      it 'renders an error message and halts execution' do
        post :create, params: valid_params.merge(walletable_id: nil)

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq("walletable id cannot be empty.")
      end
    end

    context 'when walletable_id is invalid for the given walletable_type' do
      it 'renders an error message and halts execution' do
        post :create, params: valid_params.merge(walletable_id: 99999)
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq("Invalid walletable id for the given walletable type.")
      end
    end

    context 'when all params are valid' do
      it 'proceeds with the request' do
        post :create, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Transaction successful Created')
      end
    end
  end
end
