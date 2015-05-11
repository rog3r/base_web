# encoding: utf-8
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]  
  before_action :pundit_auth

  respond_to :html
  responders :flash

  def index
   @users = build_basic_search(User.all)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.create(user_params)
    params[:save_and_new] ? (respond_with @user, location: new_user_path) : (respond_with @user)
  end

  def update
    assign_params = user_params.dup; assign_params.delete(:email) #não permitir alteração de email do usuário
    @user.update_without_password(assign_params)
    respond_with @user, location: users_path
  end

  def destroy
    @user.destroy
    respond_with @user
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params # Never trust parameters from the scary internet, only allow the white list through.
    params.require(:user).permit(:name, :email, :password, :locked, role_ids: [])
  end

  def pundit_auth
    authorize User.new
  end

end
