class SalariesSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  set_type :salaries
  attributes :forecast, :salaries
end
