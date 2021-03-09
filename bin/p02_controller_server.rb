require 'rack'
require_relative '../lib/controller_base'

class MyController < ControllerBase
  #attr_reader(:req,:res, :already_built_response)

  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = nil
  end

  def go
    if req.path == "/cats"
      render_content("hello cats!", "text/html")
    else
      redirect_to("/cats")
    end
  end

  #set response body and content_type to parameters
  def render_content(content, content_type)
    count = 0
     
    res = Rack::Response.new()

    @res.write(content)
    res["Content-Type"] = content_type

    if @res.write 
      count+= 1
    end

    if count > 1
     return @already_built_response = raise "Double render error"
    end

  end

  def redirect_to(url)
      count = 0

      @res.location = url
      @res.status = 302

      if @res.location
        count+= 1
      end

      if count > 1
        return @already_built_response = raise "Double render error"
      end
  end
  
end
app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

