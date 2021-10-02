require './config/envrionment'

#require './app/controllers/application_controller'
#require './app/controllers/log_controller'
use Rack::MethodOverride
use LogsController
use UsersController
run ApplicationController
#you can only run one thing and the controlelrs need to be after the methodoverride
