class Telegram::Bot::BaseService < Service
  include Telegram::Bot::BaseHelper

  attr_reader :chat_params, :from_params, :payload

  def initialize(chat, chat_params, from_params, payload)
    @chat = chat
    @chat_params = chat_params
    @from_params = from_params
    @payload = payload
  end

  protected

  def build_chat
		Telegrams::Chat.new(
			tg_chat_id: chat_params['id'].to_i,
      tg_type: "tg_#{chat_params['type']}",
      title: chat_params['title'],
      username: chat_params['username'],
      first_name: chat_params['first_name'],
      last_name: chat_params['last_name'],
      all_members_are_administrators:
        chat_params['all_members_are_administrators'], 
		)
  end

  def build_user
    Telegrams::User.new(
      tg_user_id: from_params['id'].to_i,
      username: from_params['username'],
      first_name: from_params['first_name'],
      last_name: from_params['last_name'],
    )
  end

  def build_message
		Telegrams::Message.new(
			tg_message_id: payload['message_id'].to_i,
      tg_from_id: from_params['id']&.to_i,
      date: payload['date'].to_i,
      tg_chat_id: payload['date'].to_i,
      data: {
        text: payload['text']
      }
		)
  end
  
  private

  def find_chat
    Telegrams::Chat.find_by(tg_chat_id: chat_params['id'].to_i)
  end

	def find_user
		Telegrams::User.find_by(tg_user_id: from_params['id'].to_i)
	end
end
