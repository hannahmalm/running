require "./config/envrionment"
class ApplicationController < Sinatra::Base 
    #controller inherits from Sinatra::Base, when server starts, it spins an instance of application controller

    configure do  #configure block tells controller where to look for views and enable sessions
        set :public_folder, 'public'
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
    end 

    get "/" do 
        erb :index
    end 

    helpers do 
        def logged_in?
            !!current_user
        end 

        def current_user 
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end 
    end 
end 
