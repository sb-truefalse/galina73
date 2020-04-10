class Telegram::Bot::Galina73::IncomeService < Telegram::Bot::BaseService
  def call(params)
    chat = @chat
    return error if chat.blank?

    income = chat.income
    return error if income.blank?
    return code(:params_empty) if params.blank?

    income.assign_attributes(amount: params.first.to_d)
    return error unless income.save

    code(:income_updated)
  end
end
