# get location from user
p "Where are you located?"

user_location = gets.chomp

p user_location

# hard code location for now
# user_location = "Chicago"


# get lat/long from google maps

# step 1- get the link
gmaps_string = "https://maps.googleapis.com/maps/api/geocode/json?address=" +user_location+"&key="+ENV.fetch('GMAPS_KEY')

require("open-uri")

# step 2- open/read it
raw_data = URI.open(gmaps_string).read

require("json")

# step 3- parse it
parsed_data = JSON.parse(raw_data)

results_array = parsed_data.fetch("results")

first_result = results_array.at(0)

geo_hash = first_result.fetch("geometry")

loc_hash = geo_hash.fetch("location")

latitude = loc_hash.fetch("lat")
longitude = loc_hash.fetch("lng")

# p latitude
# p longitude

# get stuff from dark sky
# step 1- get the link
dark_sky_string = "https://api.darksky.net/forecast/"+ENV.fetch('DARK_SKY_KEY')+"/"+latitude.to_s+","+longitude.to_s

require("open-uri")

# step 2- open/read it
dark_sky_raw_data = URI.open(dark_sky_string).read

require("json")

# step 3- parse it
parsed_data = JSON.parse(dark_sky_raw_data)
#p parsed_data.keys

#p parsed_data.fetch("hourly").fetch("data")[0]

# {"time"=>1674075600, "summary"=>"Overcast", "icon"=>"cloudy", "precipIntensity"=>0, "precipProbability"=>0, "temperature"=>36.69, "apparentTemperature"=>32.6, "dewPoint"=>31.06, "humidity"=>0.8, "pressure"=>1015.1, "windSpeed"=>4.98, "windGust"=>7.54, "windBearing"=>78, "cloudCover"=>0.98, "uvIndex"=>0, "visibility"=>10, "ozone"=>331.5}
#p parsed_data.fetch("hourly").fetch("data").length

# for x in 0..(parsed_data.fetch("hourly").fetch("data").length-1) do
#   time_at_x = Time.at(parsed_data.fetch("hourly").fetch("data")[x].fetch("time"))
#   p time_at_x
# end

#p parsed_data.fetch("hourly").fetch("data")[0].fetch("temperature").to_s

p "It is currently " + (parsed_data.fetch("hourly").fetch("data")[0].fetch("temperature").to_s) + "°F."
p "Next hour: "+ (parsed_data.fetch("hourly").fetch("data")[1].fetch("summary").to_s)

y = 0
for x in 0..12 do
  precipProbability_x = (parsed_data.fetch("hourly").fetch("data")[x].fetch("precipProbability"))
  if precipProbability_x >0.10 then
    y +=1
  end
  # p precipProbability_x
  # p y
end

if y>=1 then
  p "You might want to carry an umbrella!"
else
  p "You probably won't need an umbrella today."
end
