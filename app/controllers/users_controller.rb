class UsersController < ApplicationController
  before_action :require_no_signin!, only: [:new, :create]
  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end

  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:password, :username)
  end

end
