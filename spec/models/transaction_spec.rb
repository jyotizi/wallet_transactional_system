require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:wallet) { create(:wallet, balance: 1000) }
  let(:transaction) { build(:transaction, wallet: wallet) }

  describe 'associations' do
    it { is_expected.to belong_to(:wallet) }
  end

  describe 'validations' do
    context 'amount' do
      it 'is valid with a positive amount' do
        transaction.amount = 50
        expect(transaction).to be_valid
      end

      it 'is invalid with a non-numeric amount' do
        transaction.amount = 'not a number'
        expect(transaction).not_to be_valid
        expect(transaction.errors[:amount]).to include('is not a number')
      end

      it 'is invalid with a zero amount' do
        transaction.amount = 0
        expect(transaction).not_to be_valid
        expect(transaction.errors[:amount]).to include('must be greater than 0')
      end

      it 'is invalid with a negative amount' do
        transaction.amount = -10
        expect(transaction).not_to be_valid
        expect(transaction.errors[:amount]).to include('must be greater than 0')
      end
    end

    context 'valid_transaction' do
      it 'is invalid for debit if balance is insufficient' do
        transaction.amount = 200
        transaction.transaction_type = 'debit'
        
        expect(transaction).not_to be_valid
      end

      it 'is valid for credit regardless of balance' do
        transaction.amount = 200
        transaction.transaction_type = 'credit'
        
        expect(transaction).to be_valid
      end
    end
  end

  describe 'enum' do
    it 'defines transaction types' do
      expect(Transaction.transaction_types.keys).to contain_exactly('credit', 'debit')
    end
  end
end
