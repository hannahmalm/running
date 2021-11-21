class UsersController < ApplicationController

   get "/signup" do #render the signup page/form
        erb :'/users/signup'
   end 

    post "/signup" do #Once a user inputs into the form, post it
        if params[:username] == "" || params[:password] == "" #Ensure form is complete
            #redirect '/failure' #else redirect to failture
            flash[:message] = "Username and Password must not be blank"
            erb :'/users/signup'
        else 
            if user.valid?
            #user = User.create(params)
                user = User.create(username: params[:username], password: params[:password]) #If the form is complete, create the user
                session[:user_id] = user.id #create the session with the user id
                redirect "/logs" #redirect to the homepage
            else
                flash[:message] = user.errors.full_message
            end 
        end 

        
    end 

    get "/login" do #Get the login form
         erb :'/users/login' 
    end 

    post "/login" do #Once the user completes the form, find the user in the db
        user = User.find_by(username: params[:username]) #find_by needs a key value pair
        if user && user.authenticate(params[:password]) #if the username and password match
            session[:user_id] = user.id #create the session - will only work if set up in app controller first - This is whats actually logging the user in and assigning the key/value pair to session hash
            redirect to "/logs" #redirect to the users homepage
            #redirect to "/users/#{@user.id}"
        else 
            flash[:message] = "Please enter a valid Username and Password"
            redirect to "/login"
            #redirect to "/failure" #if the username/pass dont match, send failure mesage
        end 
    end 

    get "/failure" do #Failure message
        erb :'/failure'
    end 

    get "/logout" do #Logout if already logged in and redirect to either the login page or index page
        if logged_in?
            session.clear
            redirect "/login"
        else 
            redirect "/"
        end 
    end

end 