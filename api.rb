require "sinatra"
require "json"
require_relative 'db/database'

con = Database.new

get '/project/:number/' do | number |
	rows = con.db_select_links_by_project(number)
	JSON.dump rows
end