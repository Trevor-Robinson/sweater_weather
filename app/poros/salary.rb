class Salary
  def initialize(data)
    @title = data[:job][:title]
    @min = to_money(data[:salary_percentiles][:percentile_25])
    @max = to_money(data[:salary_percentiles][:percentile_75])
  end

  def to_money(float)
    binding.pry
  end
end
