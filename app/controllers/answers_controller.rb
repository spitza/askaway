class AnswersController < ApplicationController
  before_action :current_user, only: [:create]
  before_action :correct_user, only: :destroy
    
  def create
    @answer = Answer.new(answer_params)
    @question = @answer.question
    @conversation = @question.conversation
    if @answer.save
      @question.update_attribute(:has_answer, true)
      redirect_to @question
    else
      render 'questions/show'
    end
  end
  
  def destroy
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @answer.destroy
    @question.update_attribute(:has_answer, false)
    redirect_to @question
  end
  
  private

    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
    
    def correct_user
      @answer = Answer.find(params[:id])
      unless @answer.question.conversation.user == current_user
        redirect_to root_url
      end
    end
    
end