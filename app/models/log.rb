class Log < ActiveRecord::Base 
    belongs_to :user
    validates :date, presence: true
    validates :distance, presence: true
    validates :pace, presence: true
    #Model is a way to communicate with Data
end 