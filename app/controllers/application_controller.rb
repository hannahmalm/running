require "./config/envrionment"
class ApplicationController < Sinatra::Base 
    #controller inherits from Sinatra::Base, when server starts, it spins an instance of application controller
    #Sessions determine current users - this is a job from SINATRA
    #session method is inherited from Sinatra::Base
    #cookie = hash stored in browser that stores info on current user
    #session is hash like object that holds info on server side 
    configure do  #configure block tells controller where to look for views and enable sessions
        set :public_folder, 'public'
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security" #extra layer of security
    end 

    register Sinatra::Flash #sinatra takes this info and turns it into a hash

    get "/" do 
        # if logged_in?
        #     redirect "/users/#{current_user.id}"
        # else 
            erb :index
        # end 
    end 

    helpers do 
        def logged_in? #will return boolean t/f, if nil it will return false
            !!current_user
        end 

        def current_user 
            @current_user ||= User.find_by(id: session[:user_id]) 
            #Use ||= because if the current user is already called/found it wont look into the db again
        end 
    end 
end 
