class Akismet < ActiveRecord::Base
  belongs_to :user

  ENABLED_TYPE = [["啟用", true], ["關閉", false]]

  before_save :enabled_check
  after_create :subscribe

  protected
  def enabled_check
    if enabled_changed?
      enabled? ? subscribe : unsubscribe
    end
  end

  def subscribe
    pshb = GooglePshb.new("http://#{HOST_NAME}", "https://pubsubhubbub.appspot.com")
    pshb.subscribe("/pshbs/#{user.login}/akismet", "#{user.blog}/comments", user.generate_token)
  end

  def unsubscribe
    pshb = GooglePshb.new("http://#{HOST_NAME}", "https://pubsubhubbub.appspot.com")
    pshb.unsubscribe("/pshbs/#{user.login}/akismet", "#{user.blog}/comments", user.generate_token)
  end

  def validate
    Rakismet.key = apikey
    Rakismet.url = user.blog
    Rakismet.validate_key
  end
end
