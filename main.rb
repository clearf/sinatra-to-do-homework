require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
# 1) should be good, need to create a database first
get '/' do
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM list"
  @list = db.exec(sql)
  db.close
  erb :todos
end

# Show the details of a todo
# 1)
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'todolist', :host => 'localhost')
  sql = "SELECT * FROM contacts WHERE id = #{id}"
  @list = db.exec(sql).first
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
  redirect to("/todo/#{id}")
end
