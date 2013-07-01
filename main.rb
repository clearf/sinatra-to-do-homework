require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require 'rainbow'


# List todo items
get '/' do
  redirect to('/todos')
end

get '/todos' do
  db = PG.connect(:dbname => 'to_do', :host => 'localhost') # open db
  sql = "SELECT * FROM todos" # code to grab info from table called todos, located in a database called to_do.
  @todos = db.exec(sql) # execute code (copy) (taking from table from database, and pasting in this variable. Keep in mind the table is in an array that holds multiple hashes. Each hash is a row.)
  db.close # close db
  erb :todos
end

post '/' do
  task = params[:task]
  due = params[:due]
  priority = params[:priority]
  completed = params[:completed]
  sql = "INSERT INTO todos (task, due, priority, completed) VALUES ('#{task}', '#{due}', #{priority}, #{completed})" # storing code inside of variable.
  db = PG.connect(:dbname => 'to_do', :host => 'localhost') # open db
  db.exec(sql) # execute code (paste) (giving to database, which is why there is no variable needed)
  db.close
  redirect to '/'
end




get '/:id/add' do
  id = params[:id]
  sql = "SELECT * FROM todos WHERE id= #{id}"
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  @todo = db.exec(sql)[0]
  db.close
  erb :add
end






