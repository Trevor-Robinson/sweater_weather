class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)
    if !user.valid?
      render json: user.errors.full_messages.first, status: 422
    else
      render json: UsersSerializer.new(user)
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
