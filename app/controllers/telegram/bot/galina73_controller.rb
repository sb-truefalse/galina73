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

  def add!(params = nil)
		response = t('.title')
		create_message
		respond_with :message, text: response
	end

  def stat!(params = nil)
		response = t('.title')
		respond_with :message, text: response #, parse_mode: "HTML"
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
		Telegrams::Chat.find_by(chat_id: chat['id'].to_i)
	end

	def find_user
		Telegrams::User.find_by(user_id: chat['id'].to_i)
	end

	def create_message
		return unless message

		Telegrams::Message.create(
			message_id: message['message_id'].to_i,
      from_id: from? && from['id'].to_i,
      date: message['date'].to_i,
      chat_id: message['date'].to_i,
      data: { text: message['text'] }
		)
	end

	def create_chat
		return unless chat

		Telegrams::Chat.create(
			chat_id: chat['id'].to_i,
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
			user_id: from['id'].to_i,
      username: from['username'],
      first_name: from['first_name'],
      last_name: from['last_name'],
		)
	end
end
