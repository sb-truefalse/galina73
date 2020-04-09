FactoryBot.define do
  factory :telegrams_message, class: 'Telegrams::Message' do
    message_id { "" }
    from_id { "" }
    date { 1 }
    chat_id { "" }
    data { "" }
  end
end
