class JobPostsController < ApplicationController
    # before_action :authenticate_user!, only: [:create]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_job_post, only:[:update, :edit,:destroy,:show]
    before_action :authorize_user!, only: [:edit, :destroy]

    def new
        @job_post = JobPost.new
    end

    def create
        @job_post = JobPost.new params.require(:job_post)
            .permit(
                :title,
                :description,
                :location,
                :min_salary,
                :max_salary,
                :company_name,
            )
        @job_post.user = current_user
        if @job_post.save
            redirect_to job_post_path(@job_post)
        else
            render :new
        end
    end

    def show
        # @job_post = JobPost.find params[:id]
    end

    def index
        @job_posts = JobPost.all.order(created_at: :desc)
    end

    def edit
        # @job_post = JobPost.find params[:id]
        if can?(:edit, @job_post)
            render :edit
        else
            redirect_to job_post_path(@job_post)
        end
    end

    def update
        # @job_post = JobPost.find params[:id]
        @job_post.update params.require(:job_post)
        .permit(
            :title,
            :description,
            :location,
            :min_salary,
            :max_salary,
            :company_name
        )
        redirect_to @job_post
    end

    def destroy
        # @job_post = JobPost.find params[:id]
        if can?(:crud, @job_post)
            @job_post.destroy
            flash[:alert] = "Deleted job post"
            redirect_to job_posts_path
        end
    end

    private

    def find_job_post
        @job_post=JobPost.find params[:id]
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @job_post)
    end
end