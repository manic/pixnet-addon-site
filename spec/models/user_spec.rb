require 'spec_helper'

describe User do
  it "should create from pixnet openid" do
    registration = {
      "email" => "manic@pixnet.net",
      "nickname" => "沒力小僧"
    }
    identity_url = "http://openid.pixnet.cc/manic"

    user = User.create_from_pixnet_openid(registration, identity_url)
    user.login.should == "manic"
    user.email.should == "manic@pixnet.net"
    user.nickname.should == "沒力小僧"
    user.identity_url.should == "http://openid.pixnet.cc/manic"
  end
end

describe "User login validation" do
  it "fails validation with no login (using error_on)" do
    User.new.should have(3).errors_on(:login)
  end

  it "login 長度在 3..40 之間" do
    User.new(:login => "cs").should have(1).error_on(:login)
  end

  it "passes validation with a login" do
    User.new(:login => "csa").should have(0).errors_on(:login)
  end

  it "fails validation with illgeal login parameter" do
    User.new(:login => "@asdfb@#").should have(1).error_on(:login)
  end

  it "大寫會自動轉為小寫" do
    User.new(:login => "Manic").login.should == "manic"
  end

end

describe "User email validation" do
  it "fails validation with no login (using error_on)" do
    User.new.should have(3).errors_on(:email)
  end
end

describe "Pixnet Connection" do
  it "should return a value even open-uri is failed" do
    # no such user. so will return 404 not Found.
    User.new(:login => "asdfklawer").pixnet_link.should == "http://asdfklawer.pixnet.net"
  end

  it "return http://{login}.pixnet.net with pixnet_link" do
    User.new(:login => "Manictest1").pixnet_link.should == "http://manictest1.pixnet.net"
  end

  it "return custom domain with pixnet_link" do
    User.new(:login => "manic").pixnet_link.should == "http://www.manic.tw"
    User.new(:login => "cwyuni").pixnet_link.should == "http://www.cwyuni.tw"
  end
end

describe "Token" do

  token = Digest::MD5.hexdigest("manic")
  user = User.new(:login => "manic")

  it "generate token from md5(login)" do
    user.generate_token.should == token
  end

  it "should pass with correct token" do
    user.verify_token(token).should == true
  end

  it "should failed with wrong token" do
    user.verify_token("asdflakjsdfaf").should == false
  end
end
