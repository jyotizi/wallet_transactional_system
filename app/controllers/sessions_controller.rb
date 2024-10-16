class SessionsController < ApplicationController
  include RenderResponse

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      render_json(message: "Loged in successfully!", data: { user_id: @user.id })
    else
      render_json(status: :unauthorized)
    end
  end

  def destroy
    session[:user_id] = nil
    render_json(message: "Loged out successfully!")
  end
end
