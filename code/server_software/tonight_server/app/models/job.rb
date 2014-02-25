class Job < ActiveRecord::Base

	validates :name, presence: true
	validates :desc, presence: true
	validates :api, presence: true
	validates :filters, presence: true
	validates :toe, presence: true

	def getValidModules
		output = []
		Dir.foreach('lib/resources') do |item|
			 next if item == '.' or item == '..' or item == 'resource.rb'
				output.push(item[0..-4])
		end
		return output
	end
end


# t.string :name
# t.string :desc
# t.string :api
# t.string :filters
# t.string :toe
# t.string :output