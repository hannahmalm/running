class LogsController < ApplicationController

    get '/logs' do #get logs route and render the users main page
        not_logged_in_helper
        erb :'/users/account'
    end 

    get "/logs/all" do #DONE
        not_logged_in_helper
        if session[:user_id]
            @logs = Log.all 
            @user = User.find_by(params[:id])
            erb :'/log/all'
        end
    end 
    
    get '/logs/new' do #DONE
        not_logged_in_helper
        erb :'/log/new'
    end 


    post '/logs' do 
        not_logged_in_helper
        if log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :user_id => params[:user_id])
            redirect to "/logs/all"
        else 
            #print a flash error stating that these fields are required
            redirect to "/logs/new"
        end 
    end

    get '/logs/:id' do 
        not_logged_in_helper
        @log = Log.find_by_id(params[:id])
        erb :'/log/show'
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
        not_logged_in_helper
        @log = Log.find_by(params[:id])
        @user = User.find_by(params[:id])
        if @log && @log.user == current_user
            erb :'/log/edit'
        else 
            flash[:error] = "You can only edit your log!"
          
            #redirect to '/error'
            erb :'/users/account'
        end 
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
    # delete '/logs/:id' do 
    #     if logged_in? #check to see if a user is logged in
    #         @log = Log.find_by_id(params[:id]) #find the log id a user wants to delete
    #         if @log && @log.user == current_user #check to see if the log id matches the current user
    #             @log.delete #delete the log
    #             redirect to '/logs'
    #         else 
    #             redirect to '/error'
    #         end  
    #     else 
    #         redirect to '/login'
    #     end
    # end 

    delete '/logs/:id' do 
        not_logged_in_helper
        @log = Log.find_by_id(params[:id]) #find the log id a user wants to delete
        @user = User.find_by(params[:id])
        if @log && @log.user == current_user #check to see if the log id matches the current user
            @log.delete #delete the log
            redirect to "/users/#{user.id}" 
            #redirect to '/logs'
        else 
            flash[:delete] = "You can only delete your own logs!"
            erb :'/users/account'
        end 
    end 

end 