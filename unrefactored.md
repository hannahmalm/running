
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