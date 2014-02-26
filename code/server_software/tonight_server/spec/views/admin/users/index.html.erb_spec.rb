require 'spec_helper'

describe "admin/users/index" do

	before :each do
		FactoryGirl.create(:user);
		assign(:users, User.all)
	end

	it "displays all the users" do
		render
		expect(rendered).to include("Ryan", "Clarke")
	end

  end