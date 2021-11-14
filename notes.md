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
    │ └── environment.rb
    ├── config.ru
    ├── db
    ├── public


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

9. Models - The logic of the web app. This is where data is manipulated/saved
10. Views - The front end of the user facing part of the application. Has CSS, HTML, and Javascript. This is the only thing the user interacts with directly
11. Controllers - Go between for models and views - relays data from the view to the model and then back to the view
12. View --> Controller --> Model --> Controller --> View 
13. MVC allows for organization and to keep files seperated using seperation of concerns 
