class LogController < Sinatra::Base 
    require "./config/envrionment"
    require "./app/models/user"
    require "./app/models/log"

    #get all user logs
    get "/log" do 
        erb :log 
    end 

end 