class CreateBalanceExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :balance_expenses do |t|
      t.string :title
      t.decimal :amount
      t.bigint :chat_id

      t.timestamps
    end
  end
end
