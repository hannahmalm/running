# class LogController < Sinatra::Base 
#     require "./config/envrionment"
#     require "./app/models/user"
#     require "./app/models/log"

#     #get all user logs
#     get "/logs" do 
#         @logs = Log.all
#         erb :'/log/log'
#     end 

#     #new log 
#     get '/logs/new' do 
#         erb :'/log/new'
#     end 

#     post '/logs' do 
#         @log = Log.create(:date => params[:date], :distance => params[:distance], :pace => params[:pace], :avg_heart_rate => params[:avg_heart_rate], :notes => params[:notes], :owner_id => params[:owner_id])
#         redirect to "/logs/#{@log.id}"
#     end 
    
#     #show log 
#     get '/logs/:id' do 
#         @log = Log.find_by_id(params[:id])
#         erb :'/log/show'
#     end 

#     #edit log 
#     get '/logs/:id/edit' do 
#         @log = Log.find_by_id(params[:id])
#         erb :'/log/edit'
#     end 

#     patch '/logs/:id' do 
#         @log = Log.find_by_id(params[:id])
#         @log.date = params[:date]
#         @log.distance = params[:distance]
#         @log.pace = params[:pace]
#         @log.avg_heart_rate = params[:avg_heart_rate]
#         @log.notes = params[:notes]
#         @log.owner_id = params[:owner_id]
#         @log.save 
#         redirect to "/log/#{@log.id}"
#     end 

#     #delete a log 
#     delete '/logs/:id' do 
#         @log = Log.find_by_id(params[:id])
#         @log.delete 
#         redirect to '/logs'
#     end 
        

# end 