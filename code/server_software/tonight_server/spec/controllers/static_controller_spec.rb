require 'spec_helper'

describe StaticController do

	describe "index" do
		it "renders the index template" do
			get :index
			expect(response).to render_template("index")
			expect(response.body).to eq ""
		end

		it "renders the static/index template" do
			get :index
			expect(response).to render_template("static/index")
			expect(response.body).to eq ""
		end
 	 end
 	 	
end
