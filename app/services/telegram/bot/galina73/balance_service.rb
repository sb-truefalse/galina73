class Telegram::Bot::Galina73::BalanceService < Telegram::Bot::BaseService
  def call(params)
    chat = @chat
    return error if chat.blank?

    start_period, end_period = date_period(params)
    income = chat.income
    expenses = chat.expenses

    start_period, end_period = date_period(params)
    return code(:error_input) unless start_period || end_period

    begin
      expenses = expenses_by_period(expenses, start_period, end_period)
    rescue
      return error
    end

		period = "<i>#{start_period} — #{end_period}</i>"
    income_amount = income.amount
    expenses_amount = expenses.sum(:amount)
    balance = income_amount - expenses_amount

    data = OpenStruct.new(
      period: period, 
      income: income_amount,
      expenses: expenses_amount,
      balance: balance
    )
    success(data, code: :data)
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
