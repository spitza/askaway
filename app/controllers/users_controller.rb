class UsersController < ApplicationController

  # Need to update the create so that it redirects to the page you came from and not root URL.  May be bug with omniauth.  Investigating.
  
  def show
    @user = User.friendly.find(params[:id])
    @current = current_user
    #@conversations = @user.conversations
    #@questions = @user.questions
    @query = Query.new
    @queries = @user.queries_received.paginate(page: params[:page], :per_page => 15).popular
  end
  

  
end