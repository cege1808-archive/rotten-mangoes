class Admin::UsersController < ApplicationController

  before_action :require_admin

  def require_admin
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
    end
  end

  def index
    @all_users = User.order(:firstname).order(:lastname)
    @all_users = Kaminari.paginate_array(@all_users).page(params[:page]).per(10)
  end


end
