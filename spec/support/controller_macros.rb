module ControllerMacros
  def self.included(base)
    base.extend ClassMethods
  end

  def login_as(user)
    request.cookies["token"] = CGI::Cookie.new("token", user.token)
  end

  module ClassMethods

    def it_should_require_user_for_actions(*actions)
      actions.each do |action|
        it "#{action} action should require user" do
          get action, :id => 1 # so routes work for those requiring id
          response.should redirect_to(root_url)
          # flash[:alert].should == "You must first sign in before accessing this page."
        end
      end
    end
  end
end
