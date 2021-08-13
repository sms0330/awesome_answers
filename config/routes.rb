Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # our application is running on localhost:3000
  # Inside of this file is where we define what resources we want to be
  # available to users 

  # URL: http://localhost:3000/path 
  # HTTP Request are used to interact with  our server. They are made up of a 
  # HTTP VERB and PATH

  #When someone sends a GET request to "/" path, they are routed(sent) to welcome controller -> welcome action (method)
  get("/", {to:"welcome#index", as: "root"}) 

  #GET "/contact"
  get("/contact", {to:"contact#index"})

  #POST "/contact_submit"
  post("/contact_submit", {to:"contact#create", as: "contact_submit" }) #contact_submit has to be a string; rails will add _path to it


  #------------------------RESTful Routes----------------------------------------->
  #A RESTful route provides mapping from HTTP verbs (like GET, POST, PATCH, PUT, DELETE)
  #to the contoller CRUD actions (create, read, update, destroy).
  #It depends on the HTTP verb and the URL, and not just solely on the URL

  #RESTful Routes for Questions resource
  #1 index: GET "/resources" - return all records of that resource
  #2 show: GET "/resources/:id" - returns one instance of the resource
  #3 new: GET "/resources/new" - return a view page with form to create a resource
  #4 create: POST "/resources" - handle the submission to the "new form" and inserts a new resource in the db
  #5 edit: GET "/resources/:id/edit" - returns a view form to edit an existing resource
  #6 update: PATCH "/resources/:id" - handle submission of the "edit form" and update the resource with specific id in the db
  #7 destroy: DELETE "/resources/:id" - delete a record with specific id from the database

  #------------------------------------------------------------------------------->

  #index
  # get("/questions", to: "questions#index")

  # #new
  # get('/questions/new', {to: 'questions#new', as: :new_question})

  # #create
  # post('/questions', { to: 'questions#create', as: :create_question})

  # #show
  # get("/questions/:id", {to: "questions#show", as: :question})

  # #edit
  # get('/questions/:id/edit', {to: "questions#edit", as: :edit_question})

  # #update
  # patch('/questions/:id', {to: "questions#update"})

  # #destroy
  # delete('/questions/:id', {to: 'questions#destroy', as: :destroy_question})

  resources :questions do
    #Routes written insode of a block passed to
    #a resource method will be prefixed by
    #a path corresponding to the passed in symbol.
    #In this case, all nested routes will be pre-fixed
    #with '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
    #equivalent to :answers, except: [:show, :index, :new, :edit, :update]
    # question_answers_path(<question_id>)
    # question_answer_url(<question_id>)
    # question_answer_path(@question)
    resources :likes, shallow: true, only: [:create, :destroy]
    #oroiginal route without shallow true would be something like this:
    #questions/19/likes/30
    #with shallow true: likes/30
    get :liked, on: :collection
  end

  resources :users, only:[:new, :create]
  resource :sessions, only:[:new, :create, :destroy]
  #resource generates CRUD for us; for sessions do not need /:id; cannot allow user to edit or show a particular session
  #when using a singular resource it will generate all the routes for us but without the 'id' option
  #there is no route generated that will have an :id wildcard at the end if use singular 'resource'

  resources :job_posts, only: [:new, :create, :show, :index, :destroy, :edit, :update]

  #Delayed Job Routes:
  #We will go to this url to see this route: 'localhost:3000/delayed_job/overview'
  match(
    "/delayed_job",
    to: DelayedJobWeb,
    anchor: false,
    via: [:get, :post]
  )
  
  #---------------------API routes----------------------------->
  #The namespace method in Rails makes it so that your app will automatically
  #look in a directory called api, then in a sub directory called v1 for QuestionsController
  #api/v1/questions

  #The option 'defaults: {format: :json } will set json as the default response 
  #format for all routes contained within the block
  namespace :api, defaults:{format: :json } do
    namespace :v1 do
      resources :questions
      resource :session, only: [:create, :destroy]
      resources :users, only: [:create] do
        # get :current -> /api/v1/users/:user_id/current
        get :current, on: :collection # -> api/v1/users/current
      end
    end
    match "*unmatched_route", to: "application#not_found", via: :all
    #The route will match with any URL that hasn't been matched already
    #inside of the api namespace
    #The "*" prefix in the routes path allows this route wildcard
    #match ANYTHING
    #The "via:" argument is required and is used to specify which methods this route applies to
    #Example: via: [:get, :post, :patch]
    #via: all will match all possible methods
  end

end