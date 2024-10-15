class CreditTransaction < Transaction
  before_save :set_type

  private

  def set_type
    self.transaction_type = 'credit'
  end
end
