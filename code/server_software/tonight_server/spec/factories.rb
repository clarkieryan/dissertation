FactoryGirl.define do
	factory :job do
		name "Facebook Test"
		desc "Test job run for Facebook"
		api "facebook"
		filters '{"q" => "Birmingham Night Clubs", "type" => "page", "center" => {"latitude" => "52.4796", "longitude" => "-1.9030"}, "distance" => "50"}'
		toe "12334599930"
		output ""
	end

	factory :user do
		first_name "Ryan"
		last_name "Clarke"
		password "P4ssw0rd";
		email "clarkie.ryan@gmail.com"
	end

	factory :venue do
		ref_id "9479454944748"
		name "The Rainow Venues"
		desc "Pub in the heart of digbeth"
		street "Rainbow Road"
		city_id { |p| p.association(:city) }
		county "West Midlands"
		country "United Kingdom"
		post_code "B1 45Y"
		lat "52.132"
		lon "-1.4943"
		phone "02476456789"
		website "http://www.therainbowvenues.com"
	end

	factory :event do
		ref_id "6839057940384"
		name "House music night"
		desc "The best sounds in west midlands"
		start_time "2014-05-04 21:00:00 UTC"
		end_time "2014-05-05 05:00:00 UTC"
		timezone "Europe/London"
		venue { |p| p.association(:venue) }
		updated_at "2014-05-05 05:00:00 UTC"
	end

	factory :city do
		name "Birmingham"
	end

end