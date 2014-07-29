class ConversationsController < ApplicationController
  before_action :current_user, only: [:new, :create]
  before_action :correct_user, only: :destroy
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from NoMethodError, with: :record_not_found
  
  def new
    @conversation = Conversation.new
  end

  def show
    @conversation = Conversation.friendly.find(params[:id])
    @prompt_linked = @conversation.linked_prompt.html_safe
    #taking the conversations questions, paginating them, sorting by most votes
    @questions = @conversation.questions.paginate(page: params[:page], :per_page => 15).popular
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
  
  def destroy
    @conversation.destroy
    redirect_to root_url
  end

  private

    def conversation_params
      params.require(:conversation).permit(:prompt)
    end
    
    def record_not_found
      redirect_to root_url, notice: "That conversation doesn't exist yet."
    end
    
    def correct_user
      @conversation = current_user.conversations.friendly.find(params[:id])
      redirect_to root_url if @conversation.nil?
    end
    
end
