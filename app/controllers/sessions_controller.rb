class SessionsController < ApplicationController

  # Need to update the create so that it redirects to the page you came from and not root URL.  May be bug with omniauth.  Investigating.
  
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to (request.env['omniauth.origin'])
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
