class ConversationsController < ApplicationController
  before_action :current_user, only: [:new, :create]
  def new
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.find(params[:id])
    #@questions = @conversation.questions.paginate(page: params[:page])
    #@questions = @conversation.questions.find_with_reputation(:votes, :all, order: 'votes desc')
    @questions = @conversation.questions.paginate(page: params[:page]).popular
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
