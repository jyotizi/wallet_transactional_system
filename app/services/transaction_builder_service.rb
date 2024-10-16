class TransactionBuilderService
  def initialize(wallet, transaction_type, amount)
    @wallet = wallet
    @transaction_type = transaction_type
    @amount = amount
  end

  def build_transaction
    case @transaction_type
    when 'credit'
      CreditTransaction.new(amount: @amount, wallet: @wallet)
    when 'debit'
      DebitTransaction.new(amount: @amount, wallet: @wallet)
    else
      raise ArgumentError, "Invalid transaction type"
    end
  end
end
