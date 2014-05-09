class AnswersController < ApplicationController
  before_action :current_user, only: [:create]
  
  def create
    if current_user
      #@question = Question.find(params[:id])
      @answer = Answer.new(answer_params)
      if @answer.save
        redirect_to :back
      else
        render 'static_pages/home'
      end
    else
      redirect_to :back
    end
  end
  
  private

    def answer_params
      params.require(:answer).permit(:content, :question_id)
    end
    
end