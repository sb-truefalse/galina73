class Telegram::Bot::Galina73::StatService < Telegram::Bot::BaseService
  def call(params)
    chat = find_chat
		expenses = chat.expenses
    return code(:expenses_empty) if expenses.none?

    start_period, end_period = date_period(params)
    return code(:error_input) unless start_period || end_period

    begin
      expenses = expenses_by_period(expenses, start_period, end_period)
    rescue
      return error
    end

		date_to_text = "<i>#{start_period} — #{end_period}</i>"
		expenses_to_text = ""
		expenses.each do |expense|
			expenses_to_text << "• #{expense.title}: #{expense.amount}\n"
		end
    total_amount = expenses.sum(:amount).to_s
    
		data = OpenStruct.new(
			date: date_to_text,
			total_amount: total_amount,
			expenses: expenses_to_text
    )

    success(data, code: :expenses)
  end

  protected

  def date_period(params)
    start_period = Date.current
		end_period = Date.current

		if params.first == 'period'
      start_period = params.second&.to_date
      end_period = params.third&.to_date
    end
    
    [start_period, end_period]
  end

  def expenses_by_period(expenses, start_period, end_period)
		expenses.where(
			'created_at BETWEEN :start_period AND :end_period',
			start_period: start_period.beginning_of_day,
			end_period: end_period.end_of_day
		)
  end
end
