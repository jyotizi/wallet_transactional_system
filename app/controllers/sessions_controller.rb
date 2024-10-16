class SessionsController < ApplicationController
  include RenderResponse

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render_response(message: "Loged in successfully!", data: { user_id: @user.id })
    else
      render_response(message: "Invalid email or password", status: :unauthorized)
    end
  end

  def destroy
    session[:user_id] = nil
    render_response(message: "Loged out successfully!")
  end
end
