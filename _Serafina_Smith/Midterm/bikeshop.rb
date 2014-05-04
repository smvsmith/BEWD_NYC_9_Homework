require 'json'
require 'rest-client'
require_relative 'lib/location'

#The greeting method greets the user, and let's them know what this program is intended to do.

def greeting
  puts 'Hello, welcome to the Manhattan Bike Shop Finder'
  puts "Let's find the best, closest bike shops to you."
end

#The intersection method is responsible for getting user input in the form of their current cross streets, defined as street1 and street2. Users must identify whether they are on a street or avenue to avoid confusion. If they don't they are prompted to include it. The values are then stored in the Location class in /lib as @street1 and @street2 to be plugged into the Google Geocode API.

def intersection
  puts "What is your first cross street? (Use 'St.' or 'Ave.')"
	street1 = gets.strip
	unless street1.include?('st') || street1.include?('ave')
		puts "Please use identifiers 'Ave.' or 'St.'"
		street1 = gets.strip
	end

  puts "What is your second cross street? (Use 'St.' or 'Ave.')"
  street2 = gets.strip
	unless street2.include?('st') || street2.include?('ave')
		puts "Please use identifiers 'Ave.' or 'St.'"
		street2 = gets.strip
	end
	Location.new(street1, street2)
end

#The reload method is the end of the program. After the list of bikeshops are displayed, they are prompted to either search again or to exit the program. Users must input either "y" or "n". I added the downcase method just in case a user felt extra formal and wanted to capitalize it. If they say "y", the entire program reloads again. If they say "n", the program breaks. If they reply any other way, the reload method loops back in on itself to restart the prompt.
def reload
	puts "Would you like to search again?(y) or (n)"
	answer = gets.strip.downcase
	if answer == 'y'
	  location = intersection
	  location.get_geocode
	  location.get_location
	  location.show_stores(location.stores)
	  reload
	elsif answer == 'n'
  	puts "Thank you for using Manhattan Bikeshop Finder!"
  else 
  	puts "Please use (y) or (n)"
  	reload
	end
end

#I now recall all of the methods from both this 
greeting
location = intersection
location.get_geocode
location.get_location
location.show_stores(location.stores)
reload
