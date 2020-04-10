module Telegram::Bot::BaseHelper
	protected
	
  def set_locale
		language = from? && payload['from']['language_code']
		I18n.locale = language || I18n.default_locale
	end

	def from?
		from.present?
	end

	def private?
		payload['chat']['type'] == 'private'
	end

	def channel?
		payload['chat']['type'] == 'channel'
	end

	def group?
		payload['chat']['type'] == 'group'
	end

  private

  def find_chat
    Telegrams::Chat.find_by(tg_chat_id: chat['id'].to_i)
  end

	def find_user
		Telegrams::User.find_by(tg_user_id: from['id'].to_i)
	end
end
