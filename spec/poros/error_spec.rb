require 'rails_helper'
RSpec.describe Error do
  it 'makes Error object from data' do
    data = {status: 400, error: "Invalid photo search"}
    result = Error.new(data)
    expect(result).to be_a(Error)
    expect(result.status).to eq(400)
    expect(result.error).to eq("Invalid photo search")
  end
end
