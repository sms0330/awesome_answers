#rails g controller sessions
class SessionsController < ApplicationController
    def new #to be called up for sign in form
    end

    def create
        #here we are allowing the user to sign_in to our website; from form url: sessions_path that then got directed to this action
        @user = User.find_by_email params[:email] #email is unique so find by email for a user if it exists

        #this authenticate method is coming from has_secure_password
        #this will encrypt this password in the same way as the password at the time 
        #of sign up encryption and then it will compare the string and if the string matches it will simply return true
        if @user && @user.authenticate(params[:password]) #check if the user exists and then authenticate that user 
            #via their password; has_secure_password is allowing us access to this authenticate method
            session[:user_id] = @user.id
            #the 'session' is an object/hash useable in the controller that uses cookies to store encrypted data.
            #To sign in a user we store their user_id in the session for later use or retreival
            redirect_to root_path, notice: 'Logged in'
        else
            flash[:alert] = 'wrong email or password'
            render :new
        end

    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: 'Logged out'
    end
end