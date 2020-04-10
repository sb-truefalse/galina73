class CreateBalanceIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_incomes do |t|
      t.decimal :amount
      t.bigint :chat_id

      t.timestamps
    end
  end
end
