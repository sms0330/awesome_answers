class AnswersController < ApplicationController
    #This file was generated with: rails g controller answers
    before_action :authenticate_user!#called before both create and destroy
    #before_action :authorize_user!, only: [:edit, :update, :destroy]

    def create
        # /questions/:question_id/answers(.:format) -> Route for quick reference
        @question = Question.find params[:question_id] #question_id coming from the URL (see above)
        answer_params = params.require(:answer).permit(:body)
        @answer = Answer.new answer_params
        @answer.question = @question
        @answer.user = current_user #update controller with the current_user
        
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

        if can?(:crud, @answer)
            @answer.destroy
            redirect_to question_path(@question), notice: 'Answer Deleted'
        else
            redirect_to root_path, alert: "Not authorized!"
        end
    end
end