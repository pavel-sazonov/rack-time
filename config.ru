require_relative 'middleware/time_format'
require_relative 'app'

# use Rack::Reloader
map '/time' do
  use TimeFormat
  run App.new
end
