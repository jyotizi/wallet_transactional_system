class Transaction < ApplicationRecord
  belongs_to :wallet

  validates :amount, numericality: { greater_than: 0 }
  validate :valid_transaction

  enum transaction_type: { credit: 'credit', debit: 'debit' }

  private

  def valid_transaction
    if debit? && wallet.balance < amount
      errors.add(:base, "Insufficient balance")
    end
  end
end
