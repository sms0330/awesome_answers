class QuestionsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show] #confirm the user exists prior to creating or deleting a question
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]

    def index
        @questions = Question.all.order(created_at: :desc) 
        #Model.all is a method built into active record used to return all records of that model
        #The @ sign is necessary to make the variable available to the view pages
        #It is called an "instance variable" - think of it almost like a global variable 
    end

    def show
        #New Answer form
        @answer = Answer.new
        #Index of Answers
        @answers = @question.answers.order(created_at: :desc)
        @like = @question.likes.find_by(user: current_user)
    end

    def new
        #because Rails form helper methods need an instance of a model to work, we create a new instance
        @question = Question.new
    end

    def create
        @question = Question.new question_params
        @question.user = current_user #will need to call this in the view to display the author of the question or simply use current_user in the view

        if @question.save
            flash[:notice] = "Question created successfully!"
            redirect_to questions_path
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @question.update question_params
            redirect_to question_path(@question)
        else
            render :edit
        end
    end

    def destroy
        @question.destroy
        redirect_to questions_path
    end

    def liked
        #get all the questions that this particular logged in user has liked
        @questions = current_user.liked_questions.order(created_at: :desc)
    end

    private

    def question_params
        params.require(:question).permit(:title, :body)
    end

    def find_question
        @question = Question.find params[:id]
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @question)
    end

end