require "./config/envrionment"
require "./app/models/user"
require "./app/models/log"


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




    #----------------------------------------

    #get all user logs
    get "/logs" do 
        @logs = Log.all
        erb :'/log/log'
    end 

    #new log 
    get '/logs/new' do 
        erb :'/log/new'
    end 

    post '/logs' do 
        @log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
        redirect to "/logs/#{@log.id}"
    end 
    
    #show log 
    get '/logs/:id' do 
        @log = Log.find_by_id(params[:id])
        erb :'/log/show'
    end 

    #edit log 
    get '/logs/:id/edit' do 
        @log = Log.find_by_id(params[:id])
        erb :'/log/edit'
    end 

    patch '/logs/:id' do 
        @log = Log.find_by_id(params[:id])
        @log.date = params[:date]
        @log.distance = params[:distance]
        @log.pace = params[:pace]
        @log.avg_heart_rate = params[:avg_heart_rate]
        @log.notes = params[:notes]
        @log.owner_id = params[:owner_id]
        @log.save 
        redirect to "/log/#{@log.id}"
    end 

    #delete a log 
    delete '/logs/:id' do 
        @log = Log.find_by_id(params[:id])
        @log.delete 
        redirect to '/logs'
    end 
        


end 
