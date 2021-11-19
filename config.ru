require './config/envrionment'

#require './app/controllers/application_controller'
#require './app/controllers/log_controller'
use Rack::MethodOverride #In order to send patch and delete requests
use LogsController
use UsersController
run ApplicationController
#you can only run one thing and the controlelrs need to be after the methodoverride
#Ensure that you are mounting these controllers with USE
