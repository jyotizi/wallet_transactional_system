class TransactionsController < ApplicationController
  include RenderResponse

  def create
    wallet = find_wallet(params[:walletable_type], params[:walletable_id])
    transaction = TransactionBuilder.new(wallet, params[:transaction_type], params[:amount]).build_transaction

    if transaction.save
      render_response(status: :created, message: "Transaction successful Created", data: { transaction: transaction })
    else
      render_response(status: :unprocessable_entity, errors: transaction.errors.full_messages)
    end
  end

  private

  def find_wallet(walletable_type, walletable_id)
    walletable_type.constantize.find(walletable_id).wallet
  end
end
