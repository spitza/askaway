class QueriesController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def create
    @query = Query.create(query_params)
    if @query.save
      @query.add_evaluation(:votes, "1", current_user)
      redirect_to :back
    else
      redirect_to root_url
    end
  end
  
  def vote
    value = params[:type] == "up" ? 1 : 0
    @query = Query.find(params[:id])
    @query.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  def show
    @query = Query.find(params[:id])
    @query_with_links = @query.linked_content.html_safe
    if @query.response
      @response_with_links = @query.response.linked_content.html_safe
    end
    #for the answer form
    @response = Response.new
  end
  
  private

    def query_params
      params.require(:query).permit(:content, :asker_id, :askee_id)
    end
  
end