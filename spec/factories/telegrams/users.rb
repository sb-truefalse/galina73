FactoryBot.define do
  factory :telegrams_user, class: 'Telegrams::User' do
    user_id { "" }
    first_name { "MyString" }
    last_name { "MyString" }
    username { "MyString" }
  end
end
