Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins '127.0.0.1:5500', 'localhost:5500', 'localhost:9999' #whitelist domains
        # you can add whichever domains you want to the above list that you will allow to
        # make requests to your api. i.e. google.ca, or if you're in production, you can put
        # your app's url here
        # origins '*' allows everyone to access, which is probably not a good idea


        resource(
            '/api/*', #limit request to paths that look like localhost:3000/api
            headers: :any, #allow the requests to contain any headers
            credentials: true, #because we're sending cookies with CORS we must add this flag
            methods: [:get, :post, :patch, :put, :delete, :options ] #allow all of these http verbs
            #options verb is  being used under the hood for CORS to work, so make sure to have it
        )
    end
end

