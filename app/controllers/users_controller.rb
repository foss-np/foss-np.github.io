class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :alter_role]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :destroy, :alter_role]
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    if signed_in?
      redirect_to(root_path)
    else
  	 @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to the FOSS Nepal Forum!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def alter_role
    user = User.find(params[:id])
    user.toggle!(:admin)
    flash[:success] = "User Role altered."
    redirect_to users_url
  end
end
