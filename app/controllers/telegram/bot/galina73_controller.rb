class Telegram::Bot::Galina73Controller < Telegram::Bot::UpdatesController	
	include Telegram::Bot::BaseHelper

	before_action :set_locale	
	around_action :user_exist?, only: [:add!, :stat!]

	def start!(params = nil)
		if find_chat.present?
			response = t('.chat.title')
		else
		  create_chat
		  find_user.blank? && create_user
			response = t('.new.title')
		end

		respond_with :message, text: response
	end

	def help!(params = nil)
		response = t('.title')
		respond_with :message, text: response
	end

	def add!(*params)
		if params.blank?
			response = t('.params.empty')
			respond_with :message, text: response
		else
			create_message
			params.each_slice(2) do |title, amount|
				@chat.expenses.create(
					title: title,
					amount: amount.to_d
				)
			end
		end
	end

	def stat!(*params)
		if @chat.expenses.none?
			response = t('.empty')
			respond_with :message, text: response
		else
			expenses = @chat.expenses
			start_period = Date.current
			end_period = Date.current

			if params.first == 'period'
				begin
					start_period = params.second.to_date
					end_period = params.third.to_date	
				rescue
					response = t('.error.input')
					return respond_with :message, text: response
				end
			end

			expenses = expenses.where(
				'created_at BETWEEN :start_period AND :end_period',
				start_period: start_period.beginning_of_day,
				end_period: end_period.end_of_day
			)

			date_to_text = "<i>#{start_period} — #{end_period}</i>"
			expenses_to_text = ""
			expenses.each do |expense|
			  expenses_to_text << "• #{expense.title}: #{expense.amount}\n"
			end
	
			total_amount = expenses.sum(:amount).to_s
			response = t(
				'.data',
				date: date_to_text,
			  total_amount: total_amount,
				expenses: expenses_to_text
			)
			respond_with :message, text: response, parse_mode: "HTML"
		end
	end

	# processing non-existent commands
	def action_missing(action, *_args)
		if action_type == :command
			respond_with(
				:message,
				text: t('.error.command',command: action_options[:command])
			)
		else
			respond_with :message, text: t('.error.action',command: action)
		end
	end

	protected

	def user_exist?
		if find_chat.present?
			yield
		else
			respond_with :message, text: t('.error.user.not_exist')
		end
	end

	private

	def find_chat
		@chat ||= Telegrams::Chat.find_by(tg_chat_id: chat['id'].to_i)
	end

	def find_user
		Telegrams::User.find_by(tg_user_id: chat['id'].to_i)
	end

	def create_message
		return unless message

		Telegrams::Message.create(
			tg_message_id: message['message_id'].to_i,
      tg_from_id: from? && from['id'].to_i,
      date: message['date'].to_i,
      tg_chat_id: message['date'].to_i,
      data: { text: message['text'] }
		)
	end

	def create_chat
		return unless chat

		Telegrams::Chat.create(
			tg_chat_id: chat['id'].to_i,
      tg_type: "tg_#{chat['type']}",
      title: chat['title'],
      username: chat['username'],
      first_name: chat['first_name'],
      last_name: chat['last_name'],
      all_members_are_administrators: chat['all_members_are_administrators'], 
		)
	end

	def create_user
		return unless from

		Telegrams::User.create(
			tg_user_id: from['id'].to_i,
      username: from['username'],
      first_name: from['first_name'],
      last_name: from['last_name'],
		)
	end
end
