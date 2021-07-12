class ApplicationController < ActionController::Base
    #Parent controller of all our controllers
    #anything defined here is available to our child controllers

    #Since a user would be accessible via different controllers, lets create helper methods here to make our task easy
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
        #If the current user is not there, then create a user by whats returned on the righ side of '='
        #If current_user is holding a value, dont assign anything, leave it be
        #Otherwise find a legit user with a session id and assign that value
    end

    helper_method :current_user #this is used by any method that you need access from both the controllers and views

    def user_signed_in?
        current_user.present? #return true or false 
    end
    helper_method :user_signed_in?

    def authenticate_user! #redirect if the user is signed in or not
        redirect_to new_sessions_path, notice: 'Please sign in' unless user_signed_in?
    end
    helper_method :authenticate_user!
end