require 'set'

class Job < ActiveRecord::Base
	attr_accessor :valid_modules
	after_initialize :init

	validates :name, presence: true
	validates :desc, presence: true
	validates :api, presence: true, :inclusion => { :in => :valid_modules}
	validates :filters, presence: true
	validates :toe, presence: true

	def init
		@valid_modules ||= []
		Dir.foreach('lib/resources') do |item|
			 next if item == '.' or item == '..' or item == 'resource.rb'
			 	#Wont be called very often so O(n) complexity is fine (small #elements)
				@valid_modules.push(item[0..-4]) unless @valid_modules.include?(item[0..-4])
		end
	end
end


# t.string :name
# t.string :desc
# t.string :api
# t.string :filters
# t.string :toe
# t.string :output