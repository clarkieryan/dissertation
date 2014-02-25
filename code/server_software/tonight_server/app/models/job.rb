require 'set'

class Job < ActiveRecord::Base

	after_initialize :init
	VALID_MODULES =[];

	validates :name, presence: true
	validates :desc, presence: true
	validates :api, presence: true, :inclusion => { :in => VALID_MODULES}
	validates :filters, presence: true
	validates :toe, presence: true

	def init
		Dir.foreach('lib/resources') do |item|
			 next if item == '.' or item == '..' or item == 'resource.rb'
			 	#Wont be called very often so O(n) complexity is fine (small #elements)
				VALID_MODULES.push(item[0..-4]) unless VALID_MODULES.include?(item[0..-4])
		end
	end
end


# t.string :name
# t.string :desc
# t.string :api
# t.string :filters
# t.string :toe
# t.string :output