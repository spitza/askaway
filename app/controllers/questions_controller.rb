class QuestionsController < ApplicationController
  before_action :current_user, only: [:create]
  
  def create
    if current_user
      @question = current_user.questions.build(question_params)
      if @question.save
        redirect_to :back
      else
        render 'static_pages/home'
      end
    else
      redirect_to :back
    end
  end

  def destroy
  end
  
  def show
    @question = Question.find(params[:id])
    @conversation = @question.conversation
    @answer = Answer.new
  end 
  
  def vote
    value = params[:type] == "up" ? 1 : -1
    @question = Question.find(params[:id])
    @question.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end
  
  private

    def question_params
      params.require(:question).permit(:content, :conversation_id)
    end
    
end