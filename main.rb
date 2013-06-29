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

post '/todo/:id' do
	sql = "UPDATE tasks SET (task, description, due, urgent, complete) = "\
	"('#{params[:task]}', '#{params[:description]}', '#{params[:due]}', #{params[:urgent]}, "\
	"#{params[:complete]}) WHERE id = #{params[:id]}"
	execute_sql(sql)
	redirect to('/')
end

# create todo
get '/create_todo' do
	erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
	sql = "INSERT INTO tasks (task, description, due, urgent, complete) VALUES ('#{params[:task]}', "\
	" '#{params[:description]}', '#{params[:due]}', #{params[:urgent]}, #{params[:complete]}) "
	execute_sql(sql)
	redirect to("/")
end

get '/todo/:id/edit' do
	sql = "select * from tasks WHERE id = #{params[:id]}"
	@task = execute_sql(sql).first
	erb :edit
end
