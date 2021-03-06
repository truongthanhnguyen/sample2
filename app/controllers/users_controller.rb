class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  # before_action :find_user, only: [:show, :update, :destroy]
  
  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.user_per_page
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find params[:id]
    @microposts = @user.microposts.paginate page: params[:page], per_page: Settings.per_page
  end

  def create
  	@user = User.new user_params
  	# if @user.save
   #    # @user.send_activation_email
   #    # flash[:info] = t "mailer.please_check_email"
   #    redirect_to root_url
   if @user.save
    log_in @user
    flash[:success] = "wellcome to the sample app!"
    redirect_to @user
  else
    render "new"
  end
end

def edit
  @user = User.find params[:id]
end

def update
  @user = User.find params[:id]
  if @user.update_attributes user_params
    flash[:success] = t "user.profile_updated"
    redirect_to @user
  else
    render "edit"
  end
end

def destroy
  User.find(params[:id]).destroy
  flash[:success] = t "user.user_deleted"
  redirect_to users_url
end

def following
  @title = t "user.following"
  @user  = User.find params[:id]
  @users = @user.following.paginate(page: params[:page])
  render "show_follow"
end

def followers
  @title = t "user.followers"
  @user  = User.find params[:id]
  @users = @user.followers.paginate(page: params[:page])
  render "show_follow"
end

private
def user_params
 params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

# def find_user
#   @user = User.find_by id: params[:id]
#   unless @user
#     flash["danger"] = "error"
#     redirect_to root_url
#   end
# end

def logged_in_user
  unless logged_in?
    store_location
    flash[:danger] = t "user.please_log_in"
    redirect_to login_url
  end
end

def correct_user
  @user = User.find params[:id]
  redirect_to(root_url) unless @user == current_user
end

def admin_user
  redirect_to(root_url) unless current_user.admin?
end
end
