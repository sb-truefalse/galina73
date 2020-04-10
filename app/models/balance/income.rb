class Balance::Income < ApplicationRecord
  belongs_to :chat,
             class_name: 'Telegrams::Chat'
end
