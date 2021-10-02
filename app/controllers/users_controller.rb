class UsersController < ApplicationController

   get "/signup" do 
        erb :'/users/signup'
    end 

    post "/signup" do 
        if params[:username] == "" || params[:password] == ""
            redirect '/failure'
        else 
            User.create(username: params[:username], password: params[:password])
            redirect '/logs'
        end 
    end 

    # get '/logs' do 
    #     @user = User.find(session[:user_id])
    #     erb :'/log/log'
    # end 

    get "/login" do 
        # if logged_in?
        #     redirect to '/logs'
        # else 
            erb :'/users/login' 
    end 

    post "/login" do 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to "/logs"
        else 
            redirect to "/failure"
        end 
    end 

    get "/failure" do 
        erb :'/failure'
    end 

    get "/logout" do 
        if logged_in
            session.clear
            redirect "/login"
        else 
            redirect "/"
        end 
    end


    helpers do 
        def logged_in
            current_user
        end 

        def current_user 
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end 
    end 
end 