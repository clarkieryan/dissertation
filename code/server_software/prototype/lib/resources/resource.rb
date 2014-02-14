require 'net/http'
require 'httparty'

class Resource 
	include HTTParty

	# TODO -  Need to add in some error handling with the HTTP requests
	# TODO - Maybe use HTTP Party to do error handling etc for me
	# https://github.com/jnunemaker/httparty
	def getResource(rawURL)
		res = HTTParty.get(rawURL);
		return res.body;
	end 

	def  buildParamString(params)
		@return  = "?";
		params.each do |key, value |
			if value.class == Hash 
				@temp = "";
				value.each_with_index do | (key2,value2),index |
					if index == 0
						@temp = "#{@temp}#{value2},";
					else 
						@temp = "#{@temp}#{value2}";
					end
				end 
				value = @temp;
			end
			@return = "#{@return}#{key}=#{value}&";
		end
		return @return;
	end
end