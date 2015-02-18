class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:id => auth['uid'].to_s).first || User.create_from_omniauth(auth)
    session[:user_id] = user.id
    if user.email == user.id
      redirect_to emailconfirm_path
    else
      redirect_to (request.env['omniauth.origin'])
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
