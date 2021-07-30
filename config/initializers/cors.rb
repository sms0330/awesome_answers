Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins '127.0.0.1:5500', 'localhost:5500', 'localhost:9999' #whitelist domains
        resource(
            '/api/*', #limit request to paths that look like localhost:3000/api
            headers: :any, #allow the requested can contain any headers
            credentials: true, #because we're sending cookies with CORS we must add this
            methods: [:get, :post, :patch, :put, :delete, :options] #allow all of these http verbs
            #options verb is being used under the hood for CORS to work, so make sure
        )
    end
end