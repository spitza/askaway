class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :confirm, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  
  def show
    @user = User.friendly.find(params[:id])
    @query = Query.new
    @queries = @user.queries_received.popular
    @numQueries = @user.numQueries
    @description = @user.linked_description.html_safe
  end
  
  def confirm
    @user = current_user
    @origin = params[:origin]
  end
  
  def update
    @user = User.friendly.find(params[:id])
    @origin = params[:origin]
    if @user.update_attributes(user_params)
      # the following params[:origin] isn't from @origin above, 
      # it's a new one passed through the email confirm form (that was gotten from the @origin above)
      redirect_to (params[:origin])
    else
      render 'edit'
    end
  end
  
  def edit
    @user = User.friendly.find(params[:id])
    @description = @user.linked_description.html_safe
  end
  
  def destroy
    session[:user_id] = nil
    User.friendly.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
  end
  
  private

    def user_params
      params.require(:user).permit(:email, :fullname, :description)
    end
    
    def correct_user
      @user = User.friendly.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
  
end