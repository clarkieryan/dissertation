require 'spec_helper'

describe Job do

	it 'is invalid without a name' do
		expect(FactoryGirl.build(:job, :name => nil)).to_not be_valid;
	end

	it "is invalid without a description" do
		expect(FactoryGirl.build(:job, :desc => nil)).to_not be_valid;  
	end

	it "is invalid without an api" do
		expect(FactoryGirl.build(:job, :api => nil)).to_not be_valid;	  
	end

	it 'is invalid api specification' do
		expect(FactoryGirl.build(:job, :api => "ticketmaster")).to_not be_valid
	end

	it 'is valid api specification' do
		expect(FactoryGirl.build(:job)).to be_valid
	end

	it 'is invalid without filters' do
		expect(FactoryGirl.build(:job, :filters => nil)).to_not be_valid;
	end

	it "is invalid without a time of execution" do
		expect(FactoryGirl.build(:job, :toe => nil)).to_not be_valid;
	end

	it 'produces an array of modules' do
		expect(Job::VALID_MODULES.to_a).to eq(['facebook', 'googlePlaces'] );
	end	

end
