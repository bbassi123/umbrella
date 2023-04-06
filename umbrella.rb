#Ask user for location
p "Where are you located?"
#user_location = gets.chomp
user_location = "Seattle"
p "Checking the weather at #{user_location}...."
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Memphis&key=#{ENV.fetch("GMAPS_KEY")}".gsub("Memphis", user_location)

require "open-uri"
raw_response = URI.open(gmaps_url).read
 

require "json"
parsed_response = JSON.parse(raw_response)
results_array = parsed_response.fetch("results")
first_result = results_array.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")

# store lat and long
latitude = loc.fetch("lat")
longitude = loc.fetch("lng")
p "Your coordinates are #{latitude}, #{longitude}."

#Get the current weather from pirate weather API
pirate_url = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/"+ latitude.to_s + ","+ longitude.to_s
p pirate_url
raw_response_pirate = URI.open(pirate_url).read
 
parsed_response_pirate = JSON.parse(raw_response_pirate)
current = parsed_response_pirate.fetch("currently")
current_temp = current.fetch("temperature").round(0)

current_weather = current.fetch("summary").downcase
p "It is currently #{current_temp}°F and "+ current_weather

hourly_array = parsed_response_pirate.fetch("hourly")
hourly_data = hourly_array.fetch("data")

rain_probs = Array.new


12.times do |check_weather|
  rainprob = hourly_data.at(check_weather).fetch("precipProbability") 
  if rainprob > 0.1
    p "in #{check_weather} hours there is a #{rainprob*100}% chance of rain"
    rain_probs.push(rainprob)
  end

end
if rain_probs.length > 0 
  p "You might want to carry an umbrella!"
else 
  p "You probably won't need an umbrella today."
end
