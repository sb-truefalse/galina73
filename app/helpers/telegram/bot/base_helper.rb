module Telegram::Bot::BaseHelper
	protected
	
	def message
		payload
	end

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
end
