1. Set up the file structure
    bundle gem run_log in terminal
    create repo in github and push
    mkdir -p app/models
    mkdir app/views
    mkdir app/controllers
    touch app/controllers/application_controller.rb
    mkdir config
    touch config/envrionment.rb
    mkdir db
    mkdir -p public/stylesheets
    touch public/stylesheets/main.css
    touch README.md (already done if run with bundle gem)
    touch CONTRIBUTING.md (already done if run with bundle gem)
    touch LICENSE.md (already done if run with bundle gem)
    touch config.ru
    git add .
    git commit -m 'added file structure'

-------------------------------------------------------------


        ├── Gemfile
    ├── Gemfile.lock
    ├── README.md
    ├── Rakefile
    ├── app App directory holds MVC 
    │ ├── controllers - 
    │ │ ├── application_controller.rb - Where all the configurations, routes, and controller actions are
                - ApplicationController represents an instance of your app when the server is up and running
    │ │ ├── log_controller.rb
    │ │ └── users_controller.rb
    │ ├── models - Hold direct logic behind application; Each file is its own class
    │ │ ├── log.rb
    │ │ └── user.rb
    │ └── views - Views hold erb files because they hold HTML plus ERB (embedded ruby tags)
    │ ├── Log
    │ │ ├── log.erb (homepage of log)
    │ │ ├── edit_log.erb
    │ │ └── show_log.erb
    │ ├── User
    │ │ ├── create_user.erb
    │ │ ├── edit_user.erb
    │ │ ├── user.erb
    │ │ └── show_user.erb
    │ ├── index.erb
    │ ├── layout.erb
    │ └── users
    │ ├── create_user.erb
    │ └── edit_user.erb
    ├── config
    │ └── environment.rb - Use file to connect up all files within the app, file loads bundler and all gems in gemfile 
    ├── config.ru - Used for Rack based applications and for using Shotgun
    ├── db
        - User - Needs a unique username and password_digest
        - Log 
    ├── public - holds front end assets such as css stylesheets and javascript directories 


2. Set up gemfile and bundle install gems
3. Build out requirement file 
4. Build out config.ru file
5. Build out application_controller.rb
6. Add index.erb file in views and run shotgun to test functionality
7. Setup Rakefile - add required fields
    require ‘./config/environment’ #requiring the environment file
    require ‘sinatra/activerecord/rake’ #loads Rake tasks
8. Create DB migration
    - for every table created, create a corresponding model class in models director, and a controller 
    - Could use corneal scaffold NAME to set up folder structure and delete out spec file 
    - Created Users table - Every user should have a unique username and password digest
    - Create Log table - Every log should have a date, userid, etc.
        - have foreign key of user id
    - Rake db:migrate

9. Models - The logic of the web app. This is where data is manipulated/saved
    - User has many logs
    - User has secure password - see notes below
    - Logs belong to Users
10. Views - The front end of the user facing part of the application. Has CSS, HTML, and Javascript. This is the only thing the user interacts with directly; Created Controllers & Views simultaniously
    - Layout view = standard view that has the yield, this will also have a nav bar
11. Controllers - Go between for models and views - relays data from the view to the model and then back to the view
     - It is the responsibility of either the session/user to log in or out 
     **AFTER ADDING IN CONTROLLERS/ROUTES, ADD THEM INTO config.ru**
     - User controller has signup(get & post), login(get&post), logout(get - does not get its own view), failure route
     - Logs controller has logs(user page), get logs(render new page to create logs), post logs(actually create the new log), show logs()
12. View --> Controller --> Model --> Controller --> View 
13. MVC allows for organization and to keep files seperated using seperation of concerns 






--------------------------------------------------------------------------------------------
Users, Cookies, and Secure passwords
1. sessions - Sinatra; Inherit from Sinatra::Base
2. Secute passwords - authenticate users; Job for ActiveRecord
    - has a has_secure_password macro
3. Cookies = hash in the browser
4. Session = hash like info in the server
5. Why are cookies & sessions used?
    - HTTP is stateless - it does not carry over any request
    - Sessions and cookies help keep track of current user
6. How do sessions and cookies work
    - Request --> Browser creates cookie --> Server receives request --> Sinatra takes cookie and converts to hash --> access this hash through sessions method --> add key value pairs to session hash --> sinatra will tell the browser to update cookie for next request
7. Sinatra apps have sessions disabled by default
    - must enable them; take the cookie and turn it to a session hash
8. set session_secret because every time the server is restarted, creating a new session_secret clears out any information the browser stored- stops the server from trying to set a new cookie every time
9. Use bcrypt to salt and hash a password
    - salting = adding random string of characters to the password
    - hashing = manipulate the password so its inpossible to turn it back into the orginal
    - save passwords in user column password_digest
    - ActiveRecrod has the has secure password macro that allows you to save password and authenticate
        - All macros do is define methods for us
        - password= method : allows user to create a user with password and not password_digest attribute
            - This method uses Bcrypt to hash and salt the password THEN saves it to password_digest column
            - user enters password to password attribute --> bcrypt hashes and salts password --> bcrypt saves hashed/salted password to password_digest
            - User.create(username: params[:username], password: params[:password])
        - authenticate method : user logs in using password --> bcrypt hashes and salts input and compares this to whats saved in password_digest column

10. Full User Flow
    a. User signs up using POST request
    b. Controller action, create a user with a password attribute (NOT password digest)
        - user = User.create(username: params[:username], password: params[:password])
    c. password= method (part of Active Recrod has_secure_password macro) uses Bcrypt to hash and salt
    d. hashed and salted password is saved into password_digest column
    e. add key-value papir to session hash to keep track of current user
        session[:user_id]= user.id
    f. response to browers includes set-cookie header that tells browser to update cookie
    g. every subsequent request includes cookie and Sinatra converts cookie to session hash
    h. User logs out, clear session hash and tell the browser to remove user id from cookie
    i. User logs back in, enter username/password and post request 
    j. find username and user ActiveRecord authenticate method (part of has_secure_password) which calls bcrypt to hash/salt user input and compare it to the value is password digest column



    MVC - Model View Controller
    - Not Ruby based, just a way to organize code 
    - DSL - Domain Specific Language (Rspec tests are an example) - create a new semantic language
    - Ruby web apps are based on Rack - Rack allows Ruby to listen to and respond to web requests; Rack is a gem that responds to web request 
    - Sinatra = DSL that is used for building web apps
        - Use get and end 