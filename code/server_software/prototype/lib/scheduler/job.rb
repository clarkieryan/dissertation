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
		#TODO shouldnt have to pass in app stuff here 
		# Possibley pulled from a database
		#Dynamically load the class
		return eval(@api.capitalize).new;
	end
	#Could add in helper functions getValidFilters etc. 

end