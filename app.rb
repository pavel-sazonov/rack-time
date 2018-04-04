require_relative 'time_format'

class App
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    TimeFormat.new.call(request, response)
  end
end
