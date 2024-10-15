class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :transactions, dependent: :destroy

  def balance
    transactions.sum(:amount)
  end
end
