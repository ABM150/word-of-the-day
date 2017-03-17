require "./config/environment"
require "./app/models/project"

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		set :protection, :except => :frame_options
	end

	get "/" do
		response = HTTParty.get("http://api.pearson.com/v2/dictionaries/entries", query: {limit: 1, offset: rand(1...100000)})
		@parsed_response = JSON.parse response.body
		@chosen_word = @parsed_response["results"][0]["headword"]
		@definition = @parsed_response["results"][0]["senses"][0]["translation"]
# 		@wordlist = ["The", "Word", "Of", "The", "Day"]
# 		@chosen_word = @wordlist.sample
		erb :index
	end

end
