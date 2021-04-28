class RoadtripSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  set_type :roadtrip
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end
