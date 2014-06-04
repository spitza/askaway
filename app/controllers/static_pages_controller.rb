class StaticPagesController < ApplicationController
  def home
    @conversations = Conversation.featured.paginate(page: params[:page], :per_page => 15)
  end

  def help
  end
  
  def about
  end
end
