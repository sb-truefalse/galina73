class Telegram::Bot::Galina73::StartService < Telegram::Bot::BaseService
  def call(params)
    chat = find_chat
    user = find_user

    return code(:chat_exist) if chat.present?

    chat = build_chat
    return error unless chat.save

    user = build_user
    return error unless user.save

    code(:chat_created)
  end
end
