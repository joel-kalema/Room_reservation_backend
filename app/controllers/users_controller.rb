class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      token = issue_token(user)
      render json: { user: UserSerializer.new(user), jwt: token, role: user.role }

    elsif user.errors.messages
      render json: { errors: user.errors.messages }
    else
      render json: { error: 'User could not be created.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
