FactoryGirl.define do
	factory :job do
		name "Facebook Test"
		desc "Test job run for Facebook"
		api "facebook"
		filters '{"q" => "club", "type" => "page", "center" => {"latitude" => "52.29", "longitude" => "-1.52"}, "distance" => "50"}'
		toe "12334599930"
		output ""
	end

	factory :user do
		first_name "Ryan"
		last_name "Clarke"
		password "4WvGrKuMIla+OhmV+u9Gv7c4hm8LTMFsfYzMD+5WQhY="
		email "clarkie.ryan@gmail.com"
	end

end