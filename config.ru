require './app/controllers/application_controller'
require './app/controllers/log_controller'
use Rack::MethodOverride
run ApplicationController
run LogController
