class Service
  protected

  def success(data = nil, code: nil)
    result(true, data, code)
  end

  def error(code = nil)
    result(false, nil, code)
  end

  def code(code)
    result(true, nil, code)
  end

  def result(status, data, code)
    Result.new(status, data, code)
  end
end
