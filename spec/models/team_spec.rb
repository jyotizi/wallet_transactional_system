require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:wallet).dependent(:destroy) }
  end

  describe 'dependent destroy' do
    it 'destroys the associated wallet when team is destroyed' do
      team = Team.create!
      wallet = team.create_wallet!
      
      expect { team.destroy }.to change { Wallet.count }.by(-1)
    end
  end
end
