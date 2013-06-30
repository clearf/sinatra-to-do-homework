require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
# This connects to a database and extracts all the info
get '/' do
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "select * from todo"
  @todos = db.exec(sql)
  db.close
  erb :todos
end

# Show the details of a todo
# This connects to a database and extracts the info for the particular task
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "SELECT * FROM todo WHERE id = #{id}"
  @todos = db.exec(sql).first
  db.close
  erb :todo
end

#This connects to a database and deletes the particular task
post '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "DELETE FROM todo WHERE id = #{id}"
  result = db.exec(sql)
  db.close
  redirect to('/')
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
# This connects to a database and creates a new task based on user input
post '/create_todo' do
  task = params[:task]
  description = params[:description]
  due_date = params[:due_date]

  sql = "INSERT INTO todo (task, description, due_date, completed) VALUES ('#{task}', '#{description}', '#{due_date}', false)"
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  result = db.exec(sql)
  db.close
  # This will send you to the newly created todo
  redirect to('/')
  # redirect to("/todo/#{id}")
  # Struggled to redirect to the task immediately. Right now it redirects back to the main list
end
