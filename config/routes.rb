Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # our application is running on localhost:3000
  # Inside of this file is where we define what resources we want to be
  # available to users 

  # URL: http://localhost:3000/path 
  # HTTP Request are used to interact with  our server. They are made up of a 
  # HTTP VERB and PATH

  #When someone sends a GET request to "/" path, they are routed(sent) to welcome controller -> welcome action (method)
  get("/", {to:"welcome#index"}) 

  #GET "/contact"
  get("/contact", {to:"contact#index"})

  #POST "/contact_submit"
  post("/contact_submit", {to:"contact#create", as: "contact_submit" }) #contact_submit has to be a string; rails will add _path to it
end
