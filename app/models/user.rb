class User < ActiveRecord::Base 
    has_secure_password  #has secure password is a method that works with bcrypt gem that does not store pass in plain text
    has_many :logs
end 