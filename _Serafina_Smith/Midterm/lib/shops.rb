class Shops
	attr_accessor :name, :vicinity

	def initialize(name, vicinity)
    @name = []
    @vicinity = []
    end
	def to_s
	puts "#{name} is located at #{vicinity}\n"
	end
end

	# def parse_geocode
	# 	parsed_response = JSON.parse(response_geo)
	# end

# def get_from_digg
#   response = JSON.load(RestClient.get('http://digg.com/api/news/popular.json'))

#   response["data"]["feed"].map do |entry|
#     title = entry["content"]["title"]
#     category = entry["content"]["tags"].map { |tag| tag["display"] }.join(', ')
#     story = {title: category, category: category}

#     calculate_upvotes story
#     show_new_story_notification story

#     story
#   end
