FactoryBot.define do
  factory :transaction do
    amount { 100 }
    association :wallet
    transaction_type { 'credit' }
  end
end
