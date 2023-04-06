require "open-uri"
require "json"
require "ascii_charts"

line_width = 40

puts "="*line_width
puts "Will you need an umbrella today?".center(line_width)
puts "="*line_width
puts
puts "Where are you?"
# user_location = gets.chomp
user_location = "Brooklyn"
puts "Checking the weather at #{user_location}...."

# Get the lat/lng of location from Google Maps API

gmaps_key = "AIzaSyD8RrOFB0dPsF-leqeFJdmX3yOvcQbfNyY"

gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_key}"

# p "Getting coordinates from:"
# p gmaps_url

raw_gmaps_data = URI.open(gmaps_url).read

parsed_gmaps_data = JSON.parse(raw_gmaps_data)

results_array = parsed_gmaps_data.fetch("results")

first_result_hash = results_array.at(0)

geometry_hash = first_result_hash.fetch("geometry")

location_hash = geometry_hash.fetch("location")

latitude = location_hash.fetch("lat")

longitude = location_hash.fetch("lng")

puts "Your coordinates are #{latitude}, #{longitude}."

# Get the weather from Dark Sky API

dark_sky_key = "26f63e92c5006b5c493906e7953da893"

dark_sky_url = "https://api.darksky.net/forecast/#{dark_sky_key}/#{latitude},#{longitude}"

# p "Getting weather from:"
# p dark_sky_url

raw_dark_sky_data = URI.open(dark_sky_url).read

parsed_dark_sky_data = JSON.parse(raw_dark_sky_data)

currently_hash = parsed_dark_sky_data.fetch("currently")

current_temp = currently_hash.fetch("temperature")

minutely_hash = parsed_dark_sky_data.fetch("minutely")

next_hour_summary = minutely_hash.fetch("summary").downcase

puts "It is currently #{current_temp}°F and will be #{next_hour_summary}"

hourly_hash = parsed_dark_sky_data.fetch("hourly")

hourly_data_array = hourly_hash.fetch("data")

next_twelve_hours = hourly_data_array[1..12]

precip_prob_threshold = 0.10

any_precipitation = false

chart_data = []

next_twelve_hours.each do |hour_hash|

  precip_prob = hour_hash.fetch("precipProbability")

  if precip_prob > precip_prob_threshold
    any_precipitation = true
  end

  precip_time = Time.at(hour_hash.fetch("time"))

  seconds_from_now = precip_time - Time.now

  hours_from_now = (seconds_from_now / 60 / 60).round

  precip_percentage = (precip_prob * 100).round

  chart_data.push([hours_from_now.round, precip_percentage])
end

puts AsciiCharts::Cartesian.new(
  chart_data,
  :bar => true,
  :title => "Hours from now vs Precipitation probability"
).draw

if any_precipitation == true
  puts "You might want to take an umbrella!"
else
  puts "You probably won't need an umbrella."
end
