class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({email: params[:email]})
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome #{@user.name}. You are now logged in!"
      redirect_to new_session_path
    else
      flash[:fail] = "Oops, wrong email password combination."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
