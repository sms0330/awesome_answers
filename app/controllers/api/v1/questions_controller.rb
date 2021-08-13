class Api::V1::QuestionsController < Api::ApplicationController
    #can be generated with:
    #this: rails g controller api/v1/questions --no-assets --no-helpers --skip-template-engine
    #or this: rails g controller api::v1::questions --no-assets --no-helpers --skip-template-engine

    # Make sure to inherit from the Api::ApplicationController instead of
    # ApplicationController

    before_action :find_question, only: [:show, :destroy, :update]
    before_action :authenticate_user!, only: [ :create, :destroy, :update ]

    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        #curl -H "Accept: application/json" http://localhost:3000api/v1/questions
        questions = Question.order(created_at: :desc)
        # To stop us from overfetching extra data from the 
        # QuestionSerializer, we can use a custom serializer.
        render(json: questions, each_serializer: QuestionCollectionSerializer)
    end

    def show
        if @question
        #curl -H "Accept: application/json" http://localhost:3000/api/v1/questions/:id
        #OR
        #curl http://localhost:3000/api/v1/questions/5
        # question = Question.find(params[:id])
        render(json: @question)
        else
            render(json: {error: "Question Not Found"})
        end
    end

    def create
        question = Question.new question_params
        question.user = current_user

        # if question.save
        #     render json: { id: question.id }
        # else
        #     render(
        #         json: { errors: question.errors.messages },
        #         status: 422 #Unprocessable entity
        #     )
        # end
        question.save!
        render json: {id: question.id}
    end

    def update
        # if @question.update question_params
        #     render json: { id: @question.id }
        # else
        #     render(
        #         json: { errors: @question.errors.messages },
        #         status: 422
        #     )
        # end
        @question.update question_params
        render json: { id: @question.id }
    end

    def destroy
        if @question || @question.destroy
            head :ok
        else
            head :bad_request
        end
    end

    private

    def find_question
        @question = Question.find params[:id]
    end

    def question_params
        params.require(:question).permit(:title, :body)
    end

    def record_invalid(error)
        invalid_record = error.record
        errors = invalid_record.errors.map do |field, message|
            {
                type: error.class.to_s, #need it in string format
                record_type: invalid_record.class.to_s,
                field: field,
                message: message
            }
        end
        render(
            json: {status: 422, errors: errors },
            status: 422 #alias is :unprocessable_entity
        )
    end



end