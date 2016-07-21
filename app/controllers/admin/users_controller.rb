class Admin::UsersController < ApplicationController

  before_action :require_admin

  def require_admin
    if current_user.nil? || !current_user.admin?
      redirect_to root_path
    else
      puts current_user.id
      session[:admin_id] = current_user.id
    end
  end

  def index
    @all_users = User.order(:firstname).order(:lastname)
    @all_users = Kaminari.paginate_array(@all_users).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "You created an account for #{@user.firstname}!"    
    else
      render :new
    end

  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy 
    @user = User.find(params[:id])
    # reviews = @user.reviews
    @user.destroy
    # reviews.destroy_all
    UserMailer.user_deleted_email(@user).deliver_now
    redirect_to admin_users_path
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname,:admin, :password, :password_confirmation)
  end


end
