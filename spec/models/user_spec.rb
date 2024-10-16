require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:wallet).dependent(:destroy) }
  end

  describe 'callbacks' do
    it 'destroys associated wallet when user is destroyed' do
      user = create(:user)
      wallet = create(:wallet, walletable: user)
      expect { user.destroy }.to change { Wallet.count }.by(-1)
    end
  end
end
