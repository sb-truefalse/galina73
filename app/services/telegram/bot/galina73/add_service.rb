class Telegram::Bot::Galina73::AddService < Telegram::Bot::BaseService
  def call(params)
    chat = @chat
    return error if chat.blank?
  
    return code(:params_empty) if params.blank?

    message = build_message
    return error unless message.save
    
		params.each_slice(2) do |title, amount|
			chat.expenses.create(
				title: title,
				amount: amount.to_d
			)
		end

    code(:expenses_created)
  end
end
