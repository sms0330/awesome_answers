class QuestionsController < ApplicationController

    def index
        @questions = Question.all.order(created_at: :desc) 
        #Model.all is a method built into active record used to return all records of that model
        #The @ sign is necessary to make the variable available to the view pages
        #It is called an "instance variable" - think of it almost like a global variable 
    end

    def show
        @question = Question.find params[:id]
    end

    def new
        @new_question = Question.new
    end

    def create
        @question = Question.new params.require(:question).permit(:title, :body)

        if @question.save
            flash[:notice] = "Question created successfully!"
            redirect_to questions_path
        else
            render :new
        end
    end

    def edit
        @question = Question.find params[:id]
    end

    def update
        @question = Question.find params[:id]
        if @question.update params.require(:question).permit(:title, :body)
            redirect_to question_path(@question)
        else
            render :edit
        end
    end

    def destroy
        @question = Question.find params[:id]
        @question.destroy
        redirect_to questions_path
    end

end