class Telegrams::Chat < ApplicationRecord
  has_one :income,
           class_name: 'Balance::Income'

  has_many :expenses,
           class_name: 'Balance::Expense'

  enum tg_type: {
    tg_private: 0,
    tg_channel: 1,
    tg_group: 2
  }
end
