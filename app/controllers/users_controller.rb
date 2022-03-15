class UsersController < ApplicationController
  before_action :current_user_find, only: [:edit, :update]
  
  def index
     @users = User.all
     @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def current_user_find
    user = User.find(params[:id])
    if user != current_user
      redirect_to user_path(current_user)
    end
  end


end
