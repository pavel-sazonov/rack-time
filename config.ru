require_relative 'app'

# use Rack::Reloader
map '/time' do
  run App.new
end
