require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

helpers do
	#opens a connection to the database
	def open_connect
		PG.connect(:dbname => 'todo', :host => 'localhost')
	end

	#executes a sql string
	def execute_sql (sql_string)
		db = open_connect
		result = db.exec(sql_string)
		db.close
		result
	end
end

# List todo items
get '/' do
	sql = "SELECT * FROM tasks"
	@tasks = []
	execute_sql(sql).each do |task|
		@tasks << task
	end
	erb :todos
end

# Show the details of a todo
get '/todo/:id' do
	sql = "SELECT * FROM tasks WHERE id = '#{params[:id]}' "
	@task = execute_sql(sql).first
	erb :todo
end

# Route edits a todo
post '/todo/:id' do
	sql = "UPDATE tasks SET (task, description, due, urgent)="\
	"('#{params[:task]}', '#{params[:description]}', '#{params[:due]}',"\
	 "#{params[:urgent]}) WHERE id = #{params[:id]}"
	execute_sql(sql)
	redirect to('/')
end

# Gets the form to create a todo
get '/create_todo' do
	erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
	sql = "INSERT INTO tasks (task, description, due, urgent, complete) "\
	"VALUES ('#{params[:task]}','#{params[:description]}', '#{params[:due]}',"\
	"#{params[:urgent]}, 'f')"
	execute_sql(sql)
	redirect to("/")
end

# Gets todo to edit 
get '/todo/:id/edit' do
	sql = "SELECT * FROM tasks WHERE id = #{params[:id]}"
	@task = execute_sql(sql).first
	erb :edit
end

get '/todo/:id/delete' do
	sql = "DELETE FROM tasks WHERE id = #{params[:id]}"
	execute_sql(sql)
	redirect to('/')
end

post '/todo/:id/complete' do 
	sql = "UPDATE tasks SET(complete)=(true) WHERE id = #{params[:id]}"
	execute_sql(sql)
	redirect to('/')
end
