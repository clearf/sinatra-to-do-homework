require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


def sql_query(sql)
  db = PG.connect(:dbname => 'todo_book', :host => 'localhost')
  query_result = db.exec(sql)
  db.close



# List todo items
get '/' do
  erb :todos
end

get '/todo' do
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "SELECT * FROM tasks"
  @todos = db.exec("SELECT * FROM tasks")
  db.close
  erb :todos
end

post '/todo' do
  name = params[:name]
  time = params[:time]
  status = params[:status]
  sql = "INSERT INTO tasks (name, time, status) VALUES ('#{name}', '#{time}', #{status})"
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to '/todo'
end


# Show the details of a todo
get '/todo/:id' do
   id = params[:id]
   db = PG.connect(:dbname => 'todo', :host => 'localhost')
   sql = "SELECT * FROM todo WHERE id = #{id}"
   @todos = de.exec(sql).first
   db close
  erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  #This will send you to the newly created todo
  id = params[:id]
  name = params[:name]
  time = params[:time]
  status = params[:status]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "UPDATE tasks SET (name, time, status) = ('#{name}', '#{time}', #{status}) WHERE id = #{id}"
  redirect to "/todo/#{id}"
end

post '/todo/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "DELETE FROM tasks WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to "/todo"
end

get '/todo/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = db.exec(sql).first
  db.close
  erb :edit
end

# Update POST
post '/todo/:id' do
  id = params[:id]
  name = params[:name]
  time = params[:time]
  status = params[:status]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "UPDATE tasks SET (task, info, done) = ('#{task}', '#{info}', #{done}) WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to '/todo'
end