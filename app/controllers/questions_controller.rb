class QuestionsController < ApplicationController
  before_action :current_user, only: [:create]
  
  def create  
    @question = current_user.questions.build(question_params)
    @conversation = @question.conversation
    @questions = @conversation.questions.paginate(page: params[:page], :per_page => 15).popular
    if @question.save
      redirect_to @conversation
    else
      render 'conversations/show'
    end
  end

  #will add this
  def destroy
  end
  
  def show
    @question = Question.friendly.find(params[:id])
    @conversation = @question.conversation
    #for the answer form
    @answer = Answer.new
  end 
  
  def vote
    value = params[:type] == "up" ? 1 : 0
    @question = Question.friendly.find(params[:id])
    @question.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  private

    def question_params
      params.require(:question).permit(:content, :conversation_id)
    end
    
end