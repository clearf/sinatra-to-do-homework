# Kevon's Sinatra x PostgreSQL To Do App
require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM task_list;"

  @tasks = db.exec(sql)
  db.close

  erb :todos
end

# post '/todo/:id/update_status' do
#   db = PG.connect(:dbname => 'todolist', :host => 'localhost')


# end

# Show the details of a todo
get '/todo/:id' do
  id = params[:id]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM task_list WHERE id = #{id};"
  @task = db.exec(sql).first
  db.close

	erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  @person = params[:person].capitalize
  @task = params[:task].capitalize
  @priority = params[:priority]
  @completed = params[:completed]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "INSERT INTO task_list (person, task, priority, completed) VALUES ('#{@person}', '#{@task}', '#{@priority}', '#{@completed}');"
  db.exec(sql)
  db.close

  redirect to("/")
end

# edit todo task - show form
get '/todo/:id/edit' do
  id = params[:id]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM task_list WHERE id = #{id}"
  @task = db.exec(sql).first
  db.close

  erb :edit
end

# edit todo task - update form
post '/todo/:id' do
  id = params[:id]
  person = params[:person]
  task = params[:task]
  priority = params[:priority]
  completed = params[:completed]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "UPDATE task_list SET (person, task, priority, completed) = ('#{person}', '#{task}', '#{priority}', '#{completed}') WHERE id = #{id};"
  db.exec(sql)
  db.close

  redirect to('/')
end

# delete todo task
post '/todo/:id/delete' do
  id = params[:id]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "DELETE from task_list WHERE id = #{id}"
  db.exec(sql)
  db.close

  redirect to('/')
end
