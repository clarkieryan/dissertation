class Job

	def initialize(api, filters)
		@api = api
		@filters = filters;
		#Instantiate the correct class
		require_relative '../resources/'+@api;
		@api_instance = eval(@api.capitalize).new;
	end
	
	def getAPI 
		return @api;
	end

	def getApiInstance 
		return @api_instance;
	end

	def startJob 
		
	end
	#Could add in helper functions getValidFilters etc. 
end