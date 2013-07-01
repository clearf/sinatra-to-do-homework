require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM tasks"
  @tasks = db.exec(sql)
  db.close
  erb :todos
end

# Show the details of a todo
# 1)
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @tasks = db.exec(sql).first
  db.close
  	erb :todo #:TODO NEEDS TO BE FINISHED
end

# create todo
# i think can keep this like this
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  task = params[:task]
  due_date = params[:due_date]
  priority = params[:priority]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "INSERT INTO tasks (task, due_date, priority) VALUES ('#{task}','#{due_date}', '#{priority}')"
  db.exec(sql)
  db.close
  redirect to("/")
end




