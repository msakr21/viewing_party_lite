# frozen_string_literal: true

class UsersController < ApplicationController
  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      redirect_to '/register'
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
    params.permit(:name, :email)
  end
end
