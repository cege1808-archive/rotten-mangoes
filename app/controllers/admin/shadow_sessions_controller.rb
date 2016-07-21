class Admin::ShadowSessionsController < ApplicationController

  def create
    # require_admin

    if params[:user_id] != session[:user_id] && user_to_be = User.find(params[:user_id])

      session[:shadow_id] = session[:user_id]
      session[:user_id] = user_to_be.id 

      redirect_to movies_path, notice: "Logged on as  #{user_to_be.full_name}"
    else
      redirect_to admin_users_path, notice: "Failed to switch to user"
    end
  end

  def destroy
    user_to_be = User.find(session[:user_id])
    shadow = User.find(session[:shadow_id])

    if shadow && shadow.admin?
      session[:user_id] = session[:shadow_id]
      session[:shadow_id] = nil
      redirect_to admin_users_path, notice: "Successfully switched back to admin"

    else
      session[:user_id] = nil
      session[:shadow_id] = nil
      redirect_to movies_path, notice: "Logged out"
    end
  end

end