class LogController < Sinatra::Base 
    require "./config/envrionment"
    require "./app/models/user"
    require "./app/models/log"

    #get all user logs
    get "/logs" do 
        @logs = Log.all
        erb :log 
    end 

    #new log 
    get '/logs/new' do 
        erb :new 
    end 

    post '/logs' do 
        @logs = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
        redirect to "/logs/#{@log.id}"
    end 

        

end 