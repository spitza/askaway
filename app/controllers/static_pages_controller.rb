class StaticPagesController < ApplicationController
  def home
    @queries = Query.popular.paginate(page: params[:page], :per_page => 10)
  end

  def help
  end
  
  def about
  end
end
