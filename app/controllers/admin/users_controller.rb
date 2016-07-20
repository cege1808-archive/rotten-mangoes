class Admin::UsersController < ApplicationController

  before_action :require_admin

  def require_admin
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
    end
  end

  def index
    @all_users = User.order(:firstname).order(:lastname)
  end


end
