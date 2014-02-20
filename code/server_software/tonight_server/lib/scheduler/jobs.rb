class Jobs

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

	def getFilters 
		return @filters;
	end

	def getApiInstance 
		return @api_instance;
	end

	#Conducts the relevant stuff
	def startJob 
		
	end
	#Could add in helper functions getValidFilters etc. 
end