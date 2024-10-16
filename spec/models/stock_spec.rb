require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:wallet) }
  end

  describe 'dependent destroy' do
    it 'destroys the associated wallet when stock is destroyed' do
      stock = Stock.create!
      wallet = stock.create_wallet!
      expect { stock.destroy }.to change { Wallet.count }.by(-1)
    end
  end
end
