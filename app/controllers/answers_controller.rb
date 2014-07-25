class AnswersController < ApplicationController
  before_action :current_user, only: [:create]
    
  def create
    @answer = Answer.new(answer_params)
    @question = @answer.question
    @conversation = @question.conversation
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end
  
  private

    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
    
end