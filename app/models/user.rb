class User < ActiveRecord::Base 
    has_secure_password  #has secure password is a method that works with bcrypt gem that does not store pass in plain text
    #has_secure_password macro lets you use authenticate method - authetnicate looks at the password string then asks bcrypt if it matches
    #Save secure passwords into the database and later authenticate users
    #has secure password is a job for ACTIVE RECORD
    has_many :logs
    #validates :username, uniqueness: true

    validates :username,
    uniqueness: {
      # object = person object being validated
      # data = { model: "Person", attribute: "Username", value: <username> }
      message: ->(data) do
        "#{data[:value]} is already taken."
      end
    }
end
end 