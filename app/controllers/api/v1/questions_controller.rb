class Api::V1::QuestionsController < Api::ApplicationController
    #can be generated with:
    #this: rails g controller api/v1/questions --no-assets --no-helpers --skip-template-engine
    #or this: rails g controller api::v1::questions --no-assets --no-helpers --skip-template-engine

    # Make sure to inherit from the Api::ApplicationController instead of
    # ApplicationController

    before_action :find_question, only: [:show, :update, :destroy]
    before_action :authenticate_user!, only: [ :create, :destroy, :update ]

    def index
        #curl -H "Accept: application/json" http://localhost:3000api/v1/questions
        questions = Question.order(created_at: :desc)
        # To stop us from overfetching extra data from the 
        # QuestionSerializer, we can use a custom serializer.
        render(json: questions, each_serializer: QuestionCollectionSerializer)
    end

    def show
        #curl -H "Accept: application/json" http://localhost:3000/api/v1/questions/:id
        #OR
        #curl http://localhost:3000/api/v1/questions/5
        # question = Question.find(params[:id])
        render(json: @question)
    end

    def create
        question = Question.new question_params
        question.user = current_user

        if question.save
            render json: { id: question.id }
        else
            render(
                json: { errors: question.errors.messages },
                status: 422 #Unprocessable entity
            ) 
        end
    end

    #don't need edit within our spa as we are using a combination of different methods (difference between our normal rails erb apps and spa)
    def update
        #receive data coming from the front end and save it in db
        if @question.update question_params
            render json: {id: @question.id} #want to send id back to the user that was successfully updated
        else 
            render(
                json: { errors: @question.errors.messages },
                status: 422 #Unprocessable entity
            ) 
        end

    end

    def destroy
        @question.destroy
        render(json: {status: 200}, status: 200)
    end

    private

    def find_question
        @question = Question.find params[:id]
    end

    def question_params
        params.require(:question).permit(:title, :body)
    end

end