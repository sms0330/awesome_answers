class ContactController < ApplicationController

    # the template it renders is inside of views/controller_name/method_name.html.erb
    # so in this case index action will render out the view 'views/contact/index.html.erb'
    def index
    end

    # This handles submission of the form on "/contact_submit" (POST request)
    def create
        # inside of all controller actions you have access to 'request' object
        # that represents the request being made

        # In rails all the information from the url and body are in a hash called 'params'
        # Storing values inside of instance variable will give you access to them inside your views

        # byebug => if you add 'byebug' anywhere within your application, it will
        # stop the execution of code at the point and allow you to dig around to debug your code.

        # you can access values from params using string or symbols -> params[:full_name] or params["full_name"]
        get_name
        params[:full_name] or params["full_name"]
        @full_name = params[:full_name]
        @email = params[:email]

        # if you explicitly tell rails to render a file then it will expect a file in views
        # called 'views/contact/create.html.erb'
        # render :create
    end

    private

    def get_name 
        if params[:full_name] != ''
            @full_name = params[:full_name]
        else 
            @full_name = "Michael Owen"
        end
    end
end
