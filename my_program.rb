# get location from user
# p "Where are you located?"

# user_location = gets.chomp

# p user_location

# hard code location for now
user_location = "Chicago"


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

p latitude
p longitude

# get stuff from dark sky
