class LogsController < Sinatra::Base 

    #get all user logs
    get "/logs" do 
        if logged_in?
            @logs = Log.all
            erb :'/log/log'
        else 
            redirect to '/login'
        end 
    end 

    #new log 
    get '/logs/new' do 
        if logged_in?
            erb :'/log/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/logs' do 
        if logged_in?
            @log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
            redirect to "/logs/#{@log.id}"
        else
            redirect to '/login'
        end 
    end 
    
    #show log 
    get '/logs/:id' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            erb :'/log/show'
        else 
            redirect to '/login'
        end 
    end 

    #edit log 
    get '/logs/:id/edit' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            erb :'/log/edit'
        else 
            redirect to '/login'
        end 
    end 

    patch '/logs/:id' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            @log.date = params[:date]
            @log.distance = params[:distance]
            @log.pace = params[:pace]
            @log.avg_heart_rate = params[:avg_heart_rate]
            @log.notes = params[:notes]
            @log.owner_id = params[:owner_id]
            @log.save 
            redirect to "/log/#{@log.id}"
        else 
            redirect to '/login'
        end 
    end 

    #delete a log 
    delete '/logs/:id' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            @log.delete 
            redirect to '/logs'
        else 
            redirect to '/login'
        end
    end 
        

end 