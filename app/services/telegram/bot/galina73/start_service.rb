class Telegram::Bot::Galina73::StartService < Telegram::Bot::BaseService
  def call(params)
    chat = @chat
    user = find_user

    return code(:chat_exist) if chat.present?

    chat = build_chat
    return error unless chat.save

    user = build_user
    return error unless user.save

    income = build_income(chat)
    return error unless income.save

    code(:chat_created)
  end

  protected

  def build_income(chat)
    Balance::Income.new(
      amount: 0.0,
      chat: chat
    )
  end
end
