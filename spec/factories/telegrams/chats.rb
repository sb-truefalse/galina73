FactoryBot.define do
  factory :telegrams_chat, class: 'Telegrams::Chat' do
    chat_id { "" }
    from_id { "" }
    type { 1 }
    title { "MyString" }
    username { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    all_members_are_administrators { false }
  end
end
