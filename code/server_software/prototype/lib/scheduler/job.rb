class Job

	def initialize(api, filters)
		@api = api
		@filters = filters;
	end
	
	def getAPI 
		return @api;
	end

	def getFilters 
		return @filters;
	end

	def startJob 
		require_relative '../resources/'+@api;
		return eval(@api.capitalize).new;
	end
	#Could add in helper functions getValidFilters etc. 

end