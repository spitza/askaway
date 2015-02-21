class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:id => auth['uid'].to_s).first || User.create_from_omniauth(auth)
    session[:user_id] = user.id
    if user.email.to_i == user.id
      redirect_to emailconfirm_path(origin: request.env['omniauth.origin'])
    else
      redirect_to (request.env['omniauth.origin'])
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
