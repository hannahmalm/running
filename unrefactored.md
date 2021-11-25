
    # post "/signup" do #Once a user inputs into the form, post it
    #     #1. A user must input a username AND a password. Both fields must be populated
    #     #2. A user must have a unique username. If they dont, they will get an error that the username is taken. 
    #     if params[:username] == "" || params[:password] == "" #Ensure form is complete
    #         #redirect '/failure' #else redirect to failture
    #         flash[:message] = "Username and Password must not be blank"
    #         erb :'/users/signup'
    #     else 
    #         user = User.create(params)
    #         if user.valid?
    #             #user = User.create(username: params[:username], password: params[:password]) #If the form is complete, create the user
    #             session[:user_id] = user.id #create the session with the user id
    #             redirect "/logs" #redirect to the homepage
    #         else
    #             flash[:username] = "Sorry, this username is already taken. Please choose a different username"
    #             redirect "/signup"
    #         end 
    #     end 
    # end 




    # get "/logs" do #DONE
    #    if logged_in? #if a User is logged in, show the users account
    #         erb :'/users/account'
    #    else 
    #         redirect to '/login'
    #    end 
    # end 



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


     #show log 
    # get '/logs/:id' do #DONE
    #     if logged_in?
    #         @log = Log.find_by_id(params[:id])
    #         erb :'/log/show'
    #     else 
    #         redirect to '/login'
    #     end 
    # end 