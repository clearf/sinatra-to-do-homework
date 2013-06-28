require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?


# List todo items
get '/' do

  erb :todos
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
  @person = params[:person]
  @task = params[:task]
  @priority = params[:priority]
  @completed = params[:completed]

  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "INSERT INTO task_list (person, task, priority, completed) VALUES ('#{@person}', '#{@task}', '#{@priority}', '#{@completed}');"
  db.exec(sql)
  db.close
  #This will send you to the newly created todo
  # redirect to("/todo/#{id}")
  redirect to("/")
end
