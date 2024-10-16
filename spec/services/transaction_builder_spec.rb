require 'rails_helper'

RSpec.describe TransactionBuilder do
  let(:wallet) { create(:wallet) }
  let(:amount) { 100.0 }

  describe '#build_transaction' do
    context 'when transaction_type is credit' do
      it 'builds a CreditTransaction' do
        transaction_builder = TransactionBuilder.new(wallet, 'credit', amount)
        transaction = transaction_builder.build_transaction
        expect(transaction).to be_a(CreditTransaction)
        expect(transaction.amount).to eq(amount)
        expect(transaction.wallet).to eq(wallet)
      end
    end

    context 'when transaction_type is debit' do
      it 'builds a DebitTransaction' do
        transaction_builder = TransactionBuilder.new(wallet, 'debit', amount)
        transaction = transaction_builder.build_transaction
        expect(transaction).to be_a(DebitTransaction)
        expect(transaction.amount).to eq(amount)
        expect(transaction.wallet).to eq(wallet)
      end
    end

    context 'when transaction_type is invalid' do
      it 'raises an ArgumentError' do
        transaction_builder = TransactionBuilder.new(wallet, 'invalid_type', amount)
        expect { transaction_builder.build_transaction }.to raise_error(ArgumentError, "Invalid transaction type")
      end
    end
  end
end
