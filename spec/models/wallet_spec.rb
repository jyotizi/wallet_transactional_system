require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:walletable) }
    it { is_expected.to have_many(:transactions).dependent(:destroy) }
  end

  describe 'balance calculation' do
    let(:wallet) { create(:wallet) }

    context 'when there are no transactions' do
      it 'returns a balance of 0' do
        expect(wallet.balance).to eq(0)
      end
    end

    context 'when there are transactions' do
      before do
        create(:transaction, wallet: wallet, amount: 100)
        create(:transaction, wallet: wallet, amount: 50)
      end

      it 'calculates the correct balance' do
        expect(wallet.balance).to eq(150)
      end
    end

    context 'when transactions are negative' do
      before do
        create(:transaction, wallet: wallet, amount: 100)
        create(:transaction, wallet: wallet, amount: 30)
      end

      it 'calculates the correct balance with negative transactions' do
        expect(wallet.balance).to eq(0.13e3)
      end
    end
  end
end
