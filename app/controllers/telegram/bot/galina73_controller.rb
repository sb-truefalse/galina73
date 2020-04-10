class Telegram::Bot::Galina73Controller < Telegram::Bot::UpdatesController	
	include Telegram::Bot::BaseHelper

	before_action :set_locale	
	around_action :chat_exist?, only: [:add!, :stat!, :income!, :balance!]

	def start!(*params)
		result = start_service.call(params)
		case result.code
		when :chat_created
			respond_mess_text t('.new.title')
		when :chat_exist
			respond_mess_text t('.chat.title')
		else
			respond_mess_text t('.error.server')
		end
	end

	def help!(*params)
		respond_mess_text t('.title')
	end

	def add!(*params)
		result = add_service.call(params)
		case result.code
		when :params_empty
			respond_mess_text t('.params.empty')
		when :expenses_created
		else
			respond_mess_text t('.error.server')
		end
	end

	def stat!(*params)
		result = stat_service.call(params)
		case result.code
		when :expenses_empty
			respond_mess_text t('.empty')
		when :error_input
			respond_mess_text t('.error.input')
		when :expenses
			data = result.data
			response = t(
				'.data',
				date: data.date,
			  total_amount: data.total_amount,
				expenses: data.expenses
			)
			respond_with :message, text: response, parse_mode: "HTML"
		else
			respond_mess_text t('.error.server')
		end	
	end

	def income!(*params)
		result = income_service.call(params)
		case result.code
		when :params_empty
			respond_mess_text t('.params.empty')
		when :income_updated
		else
			respond_mess_text t('.error.server')
		end

	end

	def balance!(*params)
		result = balance_service.call(params)
		case result.code
		when :data
			data = result.data
			response = t(
				'.data',
				period: data.period, 
				income: data.income,
				expenses: data.expenses,
			  balance: data.balance
			)
			respond_with :message, text: response, parse_mode: "HTML"
		else
			respond_mess_text t('.error.server')
		end
	end

	# processing non-existent commands
	def action_missing(action, *_args)
		case action_type
		when :command
			respond_mess_text t('.error.command', command: action_options[:command])
		else
			respond_mess_text t('.error.action', command: action)
		end
	end

	protected

	def chat_exist?
		return yield if (@chat = find_chat).present?

		respond_mess_text t('.error.user.not_exist')
	end

	def respond_mess_text(text)
		respond_with :message, text: text
	end

	private

	def start_service
		Telegram::Bot::Galina73::StartService.new(@chat, chat, from, payload)
	end

	def add_service
		Telegram::Bot::Galina73::AddService.new(@chat, chat, from, payload)
	end

	def stat_service
		Telegram::Bot::Galina73::StatService.new(@chat, chat, from, payload)
	end

	def income_service
		Telegram::Bot::Galina73::IncomeService.new(@chat, chat, from, payload)
	end

	def balance_service
		Telegram::Bot::Galina73::BalanceService.new(@chat, chat, from, payload)
	end
end
