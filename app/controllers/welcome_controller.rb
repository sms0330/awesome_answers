class WelcomeController < ApplicationController

    def index
        #render(plain: "welcome to awesome answers")
        # because of Rails convention every one of these actions will
        # automatically render a template. 
        # the template it renders is inside of views/controller_name/method_name.html.erb
        # so in this case root action will render out the view 'views/welcome/index.html.erb'
    end

    def create
    end

end
