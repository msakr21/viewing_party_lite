# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # binding.pry
    @user = User.new(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      redirect_to '/users/new'
      flash[:alert] = "Error: #{error_message(@user.errors)}"
    end
  end

  def show
    @user = User.find(params[:id])
    @hosted = @user.hosted_parties
    @invited = @user.invited_parties
  end

  def discover
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
