require "sinatra"
require "json"
require_relative 'db/database'

con = Database.new

# get '/link/:number/' do | number |
# 	rows = con.db_select_links_by_project(number)
# 	JSON.dump rows
# end

get '/project/:number/' do | number |
	rows = con.db_select_links_by_project(number)
	JSON.dump rows
end

get '/user/:number/' do | number |
	rows = con.db_select_user_by_id(number)
	JSON.dump rows
end

post '/addlink/'
	userid, link, projectid = params[:userid], params[:link], params[:projectid]
	con.db_add_link_to_project(userid, link, projectid)
end

