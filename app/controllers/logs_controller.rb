class LogsController < ApplicationController
    get "/logs" do #DONE
       if logged_in?
            erb :'/users/account'
       else 
            redirect to '/login'
       end 
    end 


    #show only logs that BELONG to a user
    get "/logs/all" do 
        if logged_in?
            if  session[:user_id] 
                @logs = Log.all
                erb :'/log/all'
            else 
                redirect to '/logs'
            end 
        else 
            redirect to '/login'
        end 
    end 
    
    #new log -DONE
    get '/logs/new' do #DONE
        if logged_in?
            erb :'/log/new'
        else 
            redirect to '/login'
        end 
    end 

    post '/logs' do #DONE
        if logged_in?
            #@log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
            @log = current_user.logs.build(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :user_id => params[:user_id])
            if @log.save
                redirect to "/logs"
                #redirect to "/logs/#{@log.id}"
            else
                redirect to "/logs/new"
            end
        else
            redirect to '/login'
        end 
    end 
    
    #show log 
    get '/logs/:id' do #DONE
        if logged_in?
            @log = Log.find_by_id(params[:id])
            erb :'/log/show'
        else 
            redirect to '/login'
        end 
    end 


    #edit log 
    get '/logs/:id/edit' do  #DONE
        if logged_in?
            @log = Log.find(params[:id])
            if @log && @log.user == current_user
                erb :'/log/edit'
            else 
                redirect to '/error'
            end 
        else 
            redirect to '/login'
        end 
    end 

    get '/error' do 
        erb :'/error'
    end 

    patch '/logs/:id' do 
            @log = Log.find_by_id(params[:id])
            @log.update(distance: params[:distance])
            @log.update(pace: params[:pace])
            @log.update(avg_heart_rate: params[:avg_heart_rate])
            @log.update(notes: params[:notes])
            redirect to "/logs/#{@log.id}"        
    end 

    


    delete a log 
    delete '/logs/:id' do 
        if logged_in?
            @log = Log.find_by_id(params[:id])
            if @log && @log.user == current_user
                @log.delete
                redirect to '/logs'
            else 
                redirect to '/error'
            end  
        else 
            redirect to '/login'
        end
    end 


    helpers do 
        def logged_in?
            current_user
        end 

        def current_user 
            @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
        end 
    end 
        

end 