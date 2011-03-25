class AkismetsController < ApplicationController
  before_filter :login_required, :set_header

  def show
    @akismet = @current_user.akismet
    @pixnet = @current_user.pixnet
    redirect_to new_akismet_path if @pixnet.present? && !@akismet.present?
  end

  def new
    redirect_to akismet_path if current_user.akismet
    @akismet = Akismet.new(:user => current_user)
  end

  def create
    redirect_to akismet_path if current_user.akismet
    @akismet = Akismet.new(params[:akismet])
    @akismet.user = current_user
    if @akismet.save
      flash[:notice] = "新增成功"
      redirect_to akismet_path
    else
      flash[:error] = error_messages_from(@akismet)
      render :action => :new
    end
  end

  def edit
    @akismet = current_user.akismet
  end

  def update
    @akismet = current_user.akismet
    if @akismet.update_attributes(params[:akismet])
      flash[:notice] = "修改成功"
      redirect_to akismet_path
    else
      flash[:error] = error_messages_from(@akismet)
      render :action => :edit
    end
  end

  def destroy
    @akismet = current_user.akismet
    @akismet.destroy
    flash[:notice] = "刪除成功"
    redirect_to akismet_path
  end

  protected
  def set_header
    @header = "Akismet"
  end

end
