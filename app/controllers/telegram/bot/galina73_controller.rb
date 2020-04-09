class Telegram::Bot::Galina73Controller < Telegram::Bot::UpdatesController	
  before_action :set_locale

	def start!(params = nil)
		response = t('.title')
		respond_with :message, text: response
	end

	def help!(params = nil)
		response = t('.title')
		respond_with :message, text: response
	end

  def add!(params = nil)
		response = t('.title')
		respond_with :message, text: response
	end

  def stat!(params = nil)
		response = t('.title')
		respond_with :message, text: response
	end

  protected

  def set_locale
		language = self.payload['from']['language_code']
		I18n.locale = language || I18n.default_locale
	end
end
