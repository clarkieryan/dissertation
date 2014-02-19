require 'spec_helper'

describe Admin::StaticController do

	describe "index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
			expect(response.body).to eq ""
		end

		it "renders the admin/index template" do
			get :index
			expect(response).to render_template("admin/static/index")
			expect(response.body).to eq ""
		end
 	 end

 	 

end
