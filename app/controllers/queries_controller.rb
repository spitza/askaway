class QueriesController < ApplicationController
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  respond_to :html, :js
  
  def create
    @query = Query.create(query_params)
    if @query.save
      @query.add_evaluation(:votes, "1", current_user)
      redirect_to @query
    else
      redirect_to :back
    end
  end
  
  def vote
    value = params[:type] == "up" ? 1 : 0
    @query = Query.friendly.find(params[:id])
    @query.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  def answer_filter
    @user = User.find(params[:id])
    @answered = @user.queries_received.responded_to.popular
    respond_to do |format|
      format.js
    end
  end
  
  def no_filter
    @user = User.find(params[:id])
    @all = @user.queries_received.popular
    respond_to do |format|
      format.js
    end
  end
  
  def show
    @query = Query.friendly.find(params[:id])
    @query_with_links = @query.linked_content.html_safe
    @asker = @query.askerfunction
    @askee = @query.askee
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