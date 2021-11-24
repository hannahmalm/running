class UsersController < ApplicationController

   get "/signup" do #Render the Signup Form - DONE
        erb :'/users/signup'
   end 

    post "/signup" do #local variables because not rendering ERB - DONE
        user = User.new(params) #set local variable and inialize a new user by passing in the params
        if user.save #save the user only if the validations pass --> validations are on user model
            session[:user_id] = user.id #set the session equal to the user.id
            redirect "/logs" #once signed up, redirect to the logs page
        else 
            #this is a dynamic active record flash error that is standard for signup
            flash[:errors] = "Signup Failure: #{user.errors.full_messages.to_sentence}" #https://stackoverflow.com/questions/15043272/errors-full-messages-format-in-rails-3
            redirect "/signup" 
        end 
    end 

    get "/login" do #Get the login form -DONE
         erb :'/users/login' 
    end 

    post "/login" do #Once the user completes the form, find the user in the db - DONE
        user = User.find_by(username: params[:username]) #find_by needs a key value pair
        if user && user.authenticate(params[:password]) #if the username and password match
            session[:user_id] = user.id #create the session - will only work if set up in app controller first - This is whats actually logging the user in and assigning the key/value pair to session hash
            #redirect to "/logs"
            redirect to "/users/#{user.id}" #redirect to the users homepage
            #redirect to "/users/#{@user.id}"
        else 
            flash[:message] = "Please enter a valid Username or Password"
            redirect to "/login"
            #redirect to "/failure" #if the username/pass dont match, send failure mesage
        end 
    end 

    get "/users/:id" do #get logs route
        not_logged_in_helper
        @user = User.find_by(id: params[:id])
        @logs = Log.all
            if @user.id == session[:user_id] #additional validation in place so you cant hack into an account
                erb :'/users/account'
            else 
                redirect to "/login"
            end 
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