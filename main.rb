require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

get '/' do
  erb :todo
end

get '/todo' do
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "SELECT * FROM tasks"
  @todos = db.exec("SELECT * FROM tasks")
  db.close
  erb :todos
end

# List todo items
post '/todo' do
  task = params[:task]
  info = params[:info]
  done = params[:done]
  sql = "INSERT INTO tasks (task, info, done) VALUES ('#{task}', '#{info}', #{done})"
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to '/'
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end
