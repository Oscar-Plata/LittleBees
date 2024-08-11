class UsersController < ApplicationController

  def index
    @users = Usuario.all
  end

  def show
    @user= Usuario.find(params[:id])
  end

end
