class UsersController < ApplicationController

  # Need to update the create so that it redirects to the page you came from and not root URL.  May be bug with omniauth.  Investigating.
  
  def show
    @user = User.friendly.find(params[:id])
    @conversations = @user.conversations
    @questions = @user.questions
  end
  
end