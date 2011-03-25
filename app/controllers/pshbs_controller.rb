class PshbsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def akismet
    @user = User.find_by_login(params[:id])
    redirect_to "/" unless @user && @user.akismet.present? && @user.akismet.enabled
    if request.get?
      if !params["hub.challenge"].nil? && @user.verify_token(params["hub.verify_token"])
        @challenge = params["hub.challenge"]
        render :text => @challenge, :status => 200
      else
        @challenge = "uhoh!"
        render :action => "akismet", :status => 404, :layout => false
      end
    else # post
      if @user.pixnet.present?
        comments = JSON.parse(@user.pixnet.client.get('/blog/comments?per_page=1').body)
        if comments["comments"].size > 0
          comment = comments["comments"][0]
          Comment.create_from_comment_user(comment, @user) unless check_has_comment(comment)
        end
      end
    end
  end

  protected
  def check_has_comment(comment)
    c = @user.comments.find_by_pixnet_comment_id(comment["id"])
    return c.present?
  end

end
