require_relative "../resource";

require 'yaml'

require 'spec_helper'
 
describe Resource do
 	
 	#Before each test create a new object
	before :each do
		@resource = Resource.new
	end

	describe "#new" do
		it "creates a new Resource object and returns that object" do
			@resource.should be_an_instance_of Resource;
		end
 	end

 	describe "#getResource" do

 		before :each do 
 			stub_request(:get, "http://www.example.com/").to_return(:body => "Example Site")
 		end

 		it "should make a http get request to a server" do
 			@resource.getResource("http://www.example.com/");
 			WebMock.should have_requested(:get, "http://www.example.com/");
 		end

 		it "should respond with the text 'Example Site" do
 			@resource.getResource("http://www.example.com/").should == "Example Site";
 		end
 	end

 	it "should read hash and build a parameters list" do
 		params = {"keyword" => "test", "language" => "en", "name" => "test", "rankby" => {"prominence" => "test", "distance" => "test"}, "types" => "test", "radius" => "test" };
 		expect(@resource.buildParams(params)).to eq("?keyword=test&language=en&name=test&rankby=test,test&types=test&radius=test&");
 	end

end