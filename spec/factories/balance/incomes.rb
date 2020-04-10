FactoryBot.define do
  factory :balance_income, class: 'Balance::Income' do
    amount { "9.99" }
    chat_id { "" }
  end
end
