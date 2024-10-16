class TransactionsController < ApplicationController
  include RenderResponse
  include WalletValidation

  def create
    wallet = find_wallet(params[:walletable_type], params[:walletable_id])
    transaction = TransactionBuilderService.new(wallet, params[:transaction_type], params[:amount]).build_transaction

    if transaction.save
      render_json(status: :created, data: { transaction: transaction })
    else
      render_json(status: :unprocessable_entity, errors: transaction.errors.full_messages)
    end
  end

  private

  def find_wallet(walletable_type, walletable_id)
    walletable_type.constantize.find(walletable_id).wallet
  end
end
