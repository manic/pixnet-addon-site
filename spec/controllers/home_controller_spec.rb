require 'spec_helper'

describe HomeController do
  render_views

  describe "index" do
    it "render the index template" do
      get :index
      response.code.should == "200"
      response.should render_template(:index)
    end
  end
end
