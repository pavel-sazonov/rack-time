class TimeFormat
  KNOWN_FORMATS = %w(year month day hour minute second)

  def call(request, response)

    return response.finish if request.params.empty?

    if unknown_format(request).empty?
      response.write "#{convert_params(request)}\n"
    else
      response.status = 400
      response.write "Unknown time format [#{unknown_format(request)}]\n"
    end

    response.finish
  end

  private

  def unknown_format(request)
    not_include_params = []

    request.params["format"].split(',').each do |param|
      not_include_params << param unless KNOWN_FORMATS.include?(param)
    end

    not_include_params.join(',')
  end

  def convert_params(request)
    formatted_params = []
    time = Time.now

    request.params["format"].split(',').each do |param|
      case param
      when 'year'
        formatted_params << time.strftime('%Y')
      when 'month'
        formatted_params << time.strftime('%d')
      when 'day'
        formatted_params << time.strftime('%m')
      when 'hour'
        formatted_params << time.strftime('%H')
      when 'minute'
        formatted_params << time.strftime('%M')
      when 'second'
        formatted_params << time.strftime('%S')
      end
    end

    formatted_params.join('-')
  end
end

