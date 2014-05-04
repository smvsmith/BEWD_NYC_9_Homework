require 'rest-client'
require 'json'
require 'pry'

class Location
	attr_accessor :street1, :street2, :geo_endpoint_url, :loc_endpoint_url, :lat, :long, :stores
	#In this part I'm setting the base URLs as constants to be used to access the Google Places, and Google Geocode APIs.I'm also setting my API key as a constant as I will also be used over.

	LOC_BASE_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='
	LOC_REST_URL = '&radius=800&types=bicycle_store&sensor=false&key='
	GEO_BASE_URL = 'https://maps.googleapis.com/maps/api/geocode/json?address='
	GEO_REST_URL = '+Manhattan&sensor=false&key='
	API_KEY = 'AIzaSyDqeuBtpSy-fFwQrL2W-aB6ESzhoq29VBw'

	#In initialize i ran into a problem when I realized that since my inputs, street1 and street2 would have spaces in between and I kept getting some sort of URI error. I realized I had to encode the URLs using this shortcut in geo_endpoint_url. 

	def initialize(street1, street2)
		@street1 = street1
		@street2 = street2
		@geo_endpoint_url = "#{GEO_BASE_URL}#{URI::encode(@street1)}+and+#{URI::encode(@street2)},#{GEO_REST_URL}#{API_KEY}"
		@loc_endpoint_url = ""
		@lat = nil
		@long = nil
		@stores = []
	end

	#get_geocode is responsible for geocoding the intersection values input by the user. The Google Places API requires latitude and longitude, which is impractical for an average user to obtain without GPS...which if they had in the first place, they would not need my program :). After the latitude and longitude coordinates are accessed, I store them both as variables @lat and @long.

	def get_geocode
		response_geo = JSON.load(RestClient.get(@geo_endpoint_url))
		@lat = response_geo['results'].first['geometry']['location']['lat']
		@long = response_geo['results'].first['geometry']['location']['lng']
	end

	#The get_location method takes both @lat and @long, and plugs them into the Google Places API, where I then take the results (response_loc) and store the results (store name and address) as a hash in the variable @stores, to be accessed later.

	def get_location
		response_loc = JSON.load(RestClient.get("#{LOC_BASE_URL}#{@lat},#{@long}#{LOC_REST_URL}#{API_KEY}"))
		response_loc["results"].each do |store|	
			@stores << {store["name"] => store["vicinity"]}
		end
	end

	#This method takes the @stores variable where we stored the hash of stores from Google Places API, and puts each store and its corresponding location to a string. In this instance, the store's name is considered the key, and the store's address (or "vicinity" in Googlese) is the value, as can be seen in how I accessed the hash.
	
	def show_stores(stores)
		stores.each do |store_hash|
			puts "#{store_hash.keys.first} is at #{store_hash.values.first}"
		end
	end

end