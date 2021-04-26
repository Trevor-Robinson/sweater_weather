class Salary
  attr_reader :title,
              :min,
              :max
  def initialize(data)
    @title = data[:job][:title]
    @min = to_money(data[:salary_percentiles][:percentile_25])
    @max = to_money(data[:salary_percentiles][:percentile_75])
  end

  def to_money(float)
    (float.to_s.split('.').first.split('').insert(-4, ',').unshift('$').push('.').join) + (float.to_s.split('.').last.split('')[0..1].join)
  end
end
