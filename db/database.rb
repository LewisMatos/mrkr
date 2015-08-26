require "pg"

class Database
	def initialize
		db_connect
	end

	def db_init #Create Table
		@conn = PG.connect(dbname: 'postgres')
		@conn.exec("DROP DATABASE IF EXISTS mrkrdb")
		@conn.exec("CREATE DATABASE mrkrdb")
		@conn = PG.connect(dbname: 'mrkrdb')
		@conn.exec(IO::read("init.sql"))
	end

	def db_single_query(query, items)
		@conn.prepare('statement1', query)
		result = @conn.exec_prepared('statement1', items)
		@conn.exec("DEALLOCATE statement1")
		result
	end

	#[["SELEC SADFAS", parameters], ["SELECT ASDF", parameters]]
	def db_multiple_query(array)
		array.collect do | query |
			db_single_query(query)
		end
	end

	def db_insert_link(uri, project)
		query = 'insert into links (uri, project) values ($1, $2)'
		items = [uri, project]
		db_single_query(query, items)
	end

	def db_select_link(id)
		query = 'select * from links where id=$1'
		items = [id]
		result = db_single_query(query, items)

		resulthash(result)
	end

	def db_select_links_by_project(project)
		query = 'select * from links where project=$1'
		items = [project]
		result = db_single_query(query, items)

		resulthash(result)
	end

	def db_select_user_by_id(userid)
		query = 'select * from users where id=$1'
		items = [userid]
		result = db_single_query(query, items)

		resulthash(result)
	end

	def db_add_link_to_project(userid, link, projectid)
		query1 = 'INSERT (, uri, project) VALUES ($1, $2, $3) INTO links'
		items1 = [userid, link, projectid]
		result = db_multiple_query(query, items)
	end

	def db_select_links_by_project(projectid)
		query = 'SELECT * FROM tablename WHERE projectid=$1'
		items = [projectid]
		result = db_single_query(query, items)
	end

	private
	def resulthash(result)
		resulthash = []
		result.each do |result|
			resulthash << result
		end
		resulthash
	end

	def db_connect
		@conn = PG.connect(dbname: 'mrkrdb')
	end
end