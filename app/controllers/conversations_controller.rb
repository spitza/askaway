class ConversationsController < ApplicationController
  before_action :current_user, only: [:new, :create]
  
  def new
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.find(params[:id])
    #taking the conversations questions, paginating them, sorting by most votes
    @questions = @conversation.questions.paginate(page: params[:page]).popular
    #for the form
    @question = @conversation.questions.build
  end

  def create
    @conversation = current_user.conversations.build(conversation_params)
    if @conversation.save
      redirect_to @conversation
    else
      render 'new'
    end
  end

  private

    def conversation_params
      params.require(:conversation).permit(:prompt)
    end
end
