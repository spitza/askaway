class ResponsesController < ApplicationController
  before_action :current_user, only: [:create]    
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
  
  private

    def response_params
      params.require(:response).permit(:content, :query_id, :user_id)
    end
    
end