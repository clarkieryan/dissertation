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

	it 'is invalid without filters' do
		expect(FactoryGirl.build(:job, :filters => nil)).to_not be_valid;
	end

	it "is invalid without a time of execution" do
		expect(FactoryGirl.build(:job, :toe => nil)).to_not be_valid;
	end

	it 'produces an array of modules' do
		job = FactoryGirl.create(:job)
		expect(job.getValidModules).to eq(['facebook', 'googlePlaces'] );
	end	

end
