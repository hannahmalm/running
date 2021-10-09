class UsersController < ApplicationController

   get "/signup" do #DONE
        erb :'/users/signup'
    end 

    get "/usernames" do 
        @user = User.find_by_id(params[:id])
        @username = @user.username
    end 

    post "/signup" do #DONE
        if params[:username] == "" || params[:password] == ""
            redirect '/failure'
        else 
            @user = User.create(username: params[:username], password: params[:password])
            session[:user_id] = @user.id
            redirect "/logs"
        end 
    end 

    get "/login" do #DONE
         erb :'/users/login' 
    end 

    post "/login" do #DONE
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect to "/logs"
        else 
            redirect to "/failure"
        end 
    end 

    get "/failure" do #DONE
        erb :'/failure'
    end 

    get "/logout" do #DONE
        if logged_in?
            session.clear
            redirect "/login"
        else 
            redirect "/"
        end 
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