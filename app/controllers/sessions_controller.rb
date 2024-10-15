class SessionsController < ApplicationController
  def create
    @user = User.find_by(name: params[:name])
    if @user
      session[:user_id] = @user.id
      render json: { message: "Signed in successfully!" }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def destroy
    session[:user_id] = nil
    render json: { message: "Signed out successfully!" }, status: :ok
  end
end
