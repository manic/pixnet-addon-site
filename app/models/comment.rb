class Comment < ActiveRecord::Base
  include Rakismet::Model
  #attr_accessor :author, :author_url, :author_email, :content, :permalink, :user_ip, :user_agent, :referer

  belongs_to :user

  scope :confirmed, where(:confirmed => true)
  scope :is_spam, where(:checked_spam => true)

  def self.create_from_comment_user(comment, user)
    Rakismet.key = user.akismet.apikey
    Rakismet.url = user.blog
    c = Comment.new
    c.user                = user
    c.author              = comment["author"]
    c.author_email        = comment["email"]
    c.author_url          = comment["url"]
    c.content             = comment["body"]
    c.permalink           = comment["article"]["link"]
    c.user_ip             = comment["client_ip"]
    c.pixnet_comment_id   = comment["id"]
    c.check_spam
    return c
  end

  def check_spam
    return checked_spam if confirmed
    if self.spam?
      self.checked_spam = true
      mark_spam
    else
      self.checked_spam = false
    end
    self.confirmed = true
    self.save
  end

  def mark_spam
    return nil unless user && user.pixnet.present?
    ret = user.pixnet.client.post("/blog/comments/#{pixnet_comment_id}/mark_spam").body
    #TODO: 要處理 mark_spam 失敗的情形
    return ret
  end

end
