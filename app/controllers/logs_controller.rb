class LogsController < ApplicationController
    # get "/logs" do #DONE
    #    if logged_in? #if a User is logged in, show the users account
    #         erb :'/users/account'
    #    else 
    #         redirect to '/login'
    #    end 
    # end 

    get "/logs" do 
        not_logged_in_helper
        erb :'/users/account'
    end 


    #show all the logs
    # get "/logs/all" do 
    #     if logged_in?
    #         if  session[:user_id] 
    #             @logs = Log.all
    #             erb :'/log/all'
    #         else 
    #             redirect to '/logs'
    #         end 
    #     else 
    #         redirect to '/login'
    #     end 
    # end 

    get "/logs/all" do 
        not_logged_in_helper
        if session[:user_id]
            @logs = Log.all 
            erb :'/log/all'
        else 
            redirect to '/logs'
        end 
    end 
    
    #new log -DONE
    # get '/logs/new' do #DONE
    #     if logged_in?
    #         erb :'/log/new'
    #     else 
    #         redirect to '/login'
    #     end 
    # end 

    # post '/logs' do #DONE
    #     if logged_in?
    #         #@log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
    #         @log = current_user.logs.build(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :user_id => params[:user_id])
    #         if @log.save
    #             redirect to "/logs"
    #             #redirect to "/logs/#{@log.id}"
    #         else
    #             redirect to "/logs/new"
    #         end
    #     else
    #         redirect to '/login'
    #     end 
    # end 

    post '/logs' do 
        if !logged_in?
            redirect to '/login'
        end 
        if  
            params[:date] != "" && params[:distance] != "" && params[:pace] != "" && params[:user_id] != ""
            @log = current_user.logs.build(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :user_id => params[:user_id])
            @log.save #@log.create does not work, do this workaround 
            redirect to "/logs"
        else 
            #print a flash error stating that these fields are required
            redirect to "/logs/new"
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
    # get '/logs/:id/edit' do  #DONE
    #     if logged_in?
    #         @log = Log.find(params[:id]) #find the log you want to edit 
    #         if @log && @log.user == current_user
    #             erb :'/log/edit'
    #         else 
    #             redirect to '/error'
    #         end 
    #     else 
    #         redirect to '/login'
    #     end 
    # end 

    get '/logs/:id/edit' do 
        @log = Log.find_by(params)
        if @log.user_id != session[:user_id]
            redirect to '/errror'
        else 
            erb :'/log/edit'
        end 
    end 

    get '/error' do 
        erb :'/error'
    end 

    # patch '/logs/:id' do 
    #         @log = Log.find_by_id(params[:id])
    #         @log.update(distance: params[:distance])
    #         @log.update(pace: params[:pace])
    #         @log.update(avg_heart_rate: params[:avg_heart_rate])
    #         @log.update(notes: params[:notes])
    #         redirect to "/logs/#{@log.id}"        
    # end 


    patch '/logs/:id' do 
        log = Log.find_by_id(params[:id])
        if log.user_id == session[:user_id]
             log.update(params[:log])
             redirect to "/logs/#{log.id}"    
        end    
    end 

    #delete a log 
    delete '/logs/:id' do 
        if logged_in? #check to see if a user is logged in
            @log = Log.find_by_id(params[:id]) #find the log id a user wants to delete
            if @log && @log.user == current_user #check to see if the log id matches the current user
                @log.delete #delete the log
                redirect to '/logs'
            else 
                redirect to '/error'
            end  
        else 
            redirect to '/login'
        end
    end 

end 