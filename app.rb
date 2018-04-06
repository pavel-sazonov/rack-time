require_relative 'time_format'

class App
  def call(env)
    request = Rack::Request.new(env)
    response = Rack::Response.new
    time_format = TimeFormat.new
    format_param = request.params["format"]

    return response.finish if request.params["format"].nil?

    if time_format.unknown_format(format_param).empty?
      response.write "#{time_format.convert_params(format_param)}\n"
    else
      response.status = 400
      response.write "Unknown time format [#{time_format.unknown_format(format_param)}]\n"
    end

    response.finish
  end
end
