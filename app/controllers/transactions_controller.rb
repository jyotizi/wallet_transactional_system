class TransactionsController < ApplicationController
  def create
    wallet = find_wallet(params[:walletable_type], params[:walletable_id])
    transaction = build_transaction(wallet)

    if transaction.save
      render json: { message: "Transaction successful", transaction: transaction }, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_wallet(walletable_type, walletable_id)
    walletable_type.constantize.find(walletable_id).wallet
  end

  def build_transaction(wallet)
    transaction_type = params[:transaction_type]
    amount = params[:amount]

    if transaction_type == 'credit'
      CreditTransaction.new(amount: amount, wallet: wallet)
    elsif transaction_type == 'debit'
      DebitTransaction.new(amount: amount, wallet: wallet)
    else
      raise ArgumentError, "Invalid transaction type"
    end
  end
end
