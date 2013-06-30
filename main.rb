require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "select * from todo"
  @todos = db.exec(sql)
  db.close
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  sql = "SELECT * FROM todo WHERE id = #{id}"
  @todos = db.exec(sql).first
  db.close
  erb :todo
end

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
post '/create_todo' do
  task = params[:task]
  description = params[:description]
  due_date = params[:due_date]

  sql = "INSERT INTO todo (task, description, due_date, completed) VALUES ('#{task}', '#{description}', '#{due_date}', false)"
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  result = db.exec(sql)
  db.close
  # binding.pry
  # id = params[:id]
  # This will send you to the newly created todo
  redirect to('/')
  # redirect to("/todo/#{id}") # Struggled to redirect to the task immediately
end
