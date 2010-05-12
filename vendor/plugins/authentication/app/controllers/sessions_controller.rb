class SessionsController < ApplicationController
  layout 'admin'
  filter_parameter_logging 'password', 'password_confirmation'
  before_filter :redirect?, :only => [:new, :create]

  def new
    @session = UserSession.new
    flash[:notice] = "Welcome. Sign into #{RefinerySetting[:site_name]}"
  end

  def create
    if (@session = UserSession.create(params[:session])).valid?
      redirect_back_or_default(admin_root_url)
      flash[:notice] = "Logged in successfully"
    else
      render :action => 'new'
    end
  end

  def destroy
    current_user_session.destroy if logged_in?
    flash[:notice] = "You have been logged out."
    redirect_back_or_default(new_session_url)
  end

protected

  def redirect?
    redirect_to admin_root_url if logged_in?
  end

  def take_down_for_maintenance?;end

end
