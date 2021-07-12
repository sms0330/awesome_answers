class AnswersController < ApplicationController
    #This file was generated with: rails g controller answers
    before_action :authenticate_user!, except: [:show, :index]

    def create
        # /questions/:question_id/answers(.:format) -> Route for quick reference
        @question = Question.find params[:question_id] #question_id coming from the URL (see above)
        answer_params = params.require(:answer).permit(:body)
        @answer = Answer.new answer_params
        @answer.user = current_user
        @answer.question = @question
        @answer.save
        if @answer.persisted?
            redirect_to question_path(@question), notice: 'Answer created!' 
        else
            redirect_to question_path(@question)  
        end
    end

    def destroy
        @question = Question.find params[:question_id]
        @answer = Answer.find params[:id]
        @answer.destroy
        redirect_to question_path(@question), notice: 'Answer Deleted'
    end
end