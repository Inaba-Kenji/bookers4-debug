class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: "You have updated user successfully."
      else
        render "edit"
      end
  end

# フォロー機能実装のため
  def following
    @user = User.find(params[:id])
    @user_followings = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @user_followers = @user.followers
  end
# フォロー機能実装のため

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
