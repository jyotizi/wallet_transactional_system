class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.references :wallet, null: false, foreign_key: true
      t.string :transaction_type

      t.timestamps
    end
  end
end
