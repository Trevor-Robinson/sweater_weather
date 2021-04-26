require 'rails_helper'
RSpec.describe Coordinates do
  it 'makes Coordinates object from data' do
    coords = {:lat=>39.738453, :lng=>-104.984853}
    result = Coordinates.new(coords)
    expect(result.class).to eq(Coordinates)
    expect(result.lat).to eq(39.738453)
    expect(result.lon).to eq(-104.984853)
  end
end
