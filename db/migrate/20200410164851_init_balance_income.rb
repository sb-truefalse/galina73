class InitBalanceIncome < ActiveRecord::Migration[6.0]
  def up
    Telegrams::Chat.all.each do |chat|
      Balance::Income.create(
        chat: chat,
        amount: 0
      )
    end
  end

  def down
    Balance::Income.destroy_all
  end
end
