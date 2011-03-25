require 'spec_helper'

describe "routes to openid" do

  it "login use pixnet openid" do 
    { :get => login_path }.should route_to(:controller => "openids", :action => "pixnet")
  end

  it "logout use pixnet openid" do
    { :get => logout_path }.should route_to(:controller => "openids", :action => "logout")
  end
end
