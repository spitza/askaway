class ResponsesController < ApplicationController
  before_action :current_user, only: [:create]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: [:destroy]
  def create
    @response = Response.new(response_params)
    @query = @response.query
    @user = @response.user
    if @response.save
      @query.update_attribute(:has_response, true)
      redirect_to @user
    else
      redirect_to root_url
    end
  end
  
  def destroy
    @response = Response.find(params[:id])
    @response.query.update_attribute(:has_response, false)
    @response.destroy
    redirect_to :back
  end
  
  private

    def response_params
      params.require(:response).permit(:content, :query_id, :user_id)
    end
    
    def correct_user
      @response = Response.find(params[:id])
      redirect_to(root_url) unless @response.user == current_user || @response.query.askerfunction == current_user
    end
    
end