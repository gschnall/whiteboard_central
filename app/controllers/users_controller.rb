class UsersController < ApplicationController
  before_action :authorize 
  before_action :logged_in?, only:[:show,:edit,:update,:destroy]

  def index
     if params[:search]
       @users = User.search(params[:search]).order("created_at DESC")
     else
       @users = User.order("created_at DESC")
     end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path @user
    else
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to user_path @user
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to boards_path
    end
  end

  private
    def user_params 
      params.require(:user).permit(:email, :password, :name, :about)  
    end    

end
