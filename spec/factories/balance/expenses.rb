FactoryBot.define do
  factory :balance_expense, class: 'Balance::Expense' do
    title { "MyString" }
    amount { "" }
  end
end
