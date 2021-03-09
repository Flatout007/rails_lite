require 'rack'

app = Proc.new() do |env|
    req = Rack::Request.new(env) #request
    res = Rack::Response.new() #response

    res["Content-Type"] = "text/html"
    
    if req.path != '/i/love/app/academy' # path parses the url
       res.write("Hello World")
    else
        res.write('/i/love/app/academy')
    end
    res.finish()
end

Rack::Server.start(
    app: app,
    Port: 3000
)
  
