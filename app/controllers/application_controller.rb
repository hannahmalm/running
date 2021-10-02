require "./config/envrionment"
require "./app/models/user"


class ApplicationController < Sinatra::Base 

    configure do 
        set :views, "app/views"
        enable :sessions
        set :session_secret, "password_security"
    end 

    get "/" do 
        erb :'/users/index'
    end 

    get "/signup" do 
        erb :'/users/signup'
    end 

    post "/signup" do 
        if params[:username] == "" || params[:password] == ""
            redirect '/failure'
        else 
            User.create(username: params[:username], password: params[:password])
            redirect '/login'
        end 
    end 

    get '/account' do 
        @user = User.find(session[:user_id])
        erb :'/users/account'
    end 

    get "/login" do 
        erb :'/users/login'
    end 

    post "/login" do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/account"
        else 
            redirect to "/failure"
        end 
    end 

    get "/failure" do 
        erb :'/users/failure'
    end 

    get "/logout" do 
        session.clear 
        redirect "/"
    end 

    helpers do 
        def logged_in?
            !!session[:user_id]
        end 

        def current_user 
            User.find(session[:user_id])
        end 
    end 

end 
