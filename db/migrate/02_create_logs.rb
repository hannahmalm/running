class CreateLogs < ActiveRecord::Migration[4.2]
    def change 
        create_table :logs do |t|
            t.date :date
            t.string :distance
            t.string :pace
            t.string :avg_heart_rate
            t.string :notes
            t.integer :owner_id
        end 
    end 
end 