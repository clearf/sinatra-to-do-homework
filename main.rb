require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "select * from to_do_list"
  @todos = db.exec(sql)
  db.close
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
  @task_name = params[:task_name]
  @task_description = params[:task_description]
  @is_it_finished = params[:is_it_finished]
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
