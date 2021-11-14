class CreateUsers < ActiveRecord::Migration[4.2]
    def change 
        create_table :users do |t|
            t.string :username 
            t.string :password_digest 
        end 
    end 
end 

#Migrations are a way to organize and alter database
#Use activerecord gem to create a mapping between our database and model 
#Migrations are like version control for database