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

# Show individual task details
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @tasks = db.exec(sql).first
  db.close
  	erb :todo
end

# Create new task
get '/create_todo' do
  erb :create_todo
end

# Create a new task by sending a POST request to this URL
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

# Edit todo task
get '/todo/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @tasks = db.exec(sql).first
  db.close
  erb:edit
end

post '/todo/:id/edit' do
  id = params[:id]
  task = params[:task]
  due_date = params[:due_date]
  priority = params[:priority]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "UPDATE tasks SET (task, due_date, priority) = ('#{task}', '#{due_date}', '#{priority}') WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to '/'
end

# Delete todo task
post '/todo/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "DELETE FROM tasks WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to "/"
end
