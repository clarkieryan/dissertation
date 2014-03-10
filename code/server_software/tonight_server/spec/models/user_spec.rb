require 'spec_helper'

describe User do
  
  	it 'is invalid without a first name' do
  		expect(FactoryGirl.build(:user, :first_name => nil)).to_not be_valid;
  	end

  	it 'is invalid without a last name' do
  		expect(FactoryGirl.build(:user, :last_name => nil)).to_not be_valid;
  	end

  	it ' is invalid without a password' do
  		expect(FactoryGirl.build(:user, :password_in => nil)).to_not be_valid;
  	end

  	it "is invalid with an email" do
  	  	expect(FactoryGirl.build(:user, :email => nil)).to_not be_valid;
  	end

  	it 'returns a users name string' do
  		expect(FactoryGirl.build(:user).name).to eq("Ryan Clarke");
  	end	

  	it 'authenticates a valid user' do
  		user = FactoryGirl.build(:user)
  		user.save!
  		expect(User.authenticate("clarkie.ryan@gmail.com", "P4ssw0rd")).to eq(true)
  	end

  	it 'doesnt authenticate non-valid user' do
  		FactoryGirl.create(:user)
  		expect(User.authenticate("ryc@aber.ac.uk", "4WvGrKuD+5WQhY=")).to eq(false)
  	end

end
