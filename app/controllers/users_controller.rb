class UsersController < ApplicationController

  # Need to update the create so that it redirects to the page you came from and not root URL.  May be bug with omniauth.  Investigating.
  
  def show
    @user = User.friendly.find(params[:id])
    @query = Query.new
    @queries = @user.queries_received.popular
    @numQueries = @user.numQueries
    @description = @user.linked_description.html_safe
  end
  
  def confirm
    if current_user && current_user.email.blank?
      @user = current_user
    else
      redirect_to root_url
    end
  end
  
  def update
    @user = User.friendly.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
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
  
end