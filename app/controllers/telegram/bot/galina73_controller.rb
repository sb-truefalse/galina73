# Available methods: from, chat
class Telegram::Bot::Galina73Controller < Telegram::Bot::UpdatesController	
	include Telegram::Bot::BaseHelper

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

	# processing non-existent commands
	def action_missing(action, *_args)
		if action_type == :command
			respond_with(
				:message,
				text: t('.command_error',command: action_options[:command])
			)
		else
			respond_with :message, text: t('.action_error',command: action)
		end
	end
end
