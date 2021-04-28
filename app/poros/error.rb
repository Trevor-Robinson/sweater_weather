class Error
  attr_reader :error,
              :status
  def initialize(data)
    @error = data[:error]
    @status = data[:status]
  end
end
