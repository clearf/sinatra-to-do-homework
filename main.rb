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

post '/todos' do
  task = params[:task]
  due = params[:due]
  priority = params[:priority]
  # completed = params[:completed]
  sql = "INSERT INTO todos (task, due, priority) VALUES ('#{task}', '#{due}', #{priority})" # storing code inside of variable.
  db = PG.connect(:dbname => 'to_do', :host => 'localhost') # open db
  db.exec(sql) # execute code (paste) (giving to database, which is why there is no variable needed)
  db.close
  redirect to '/'
end

get '/todos/add' do
  erb :add
end

post '/todos/add' do

  id = params[:id]
  task = params[:task]
  due = params[:due]
  priority = params[:priority]
  completed = params[:completed]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "UPDATE todos SET (task, due, priority, completed) = ('#{task}', '#{due}', #{priority}, #{completed}) WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to('/todos')
end

get '/todos/todo/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * from todos WHERE id = #{id}"
  @todo = db.exec(sql).first
  db.close
  erb :edit
end

get '/todos/todo/:id' do

  id = params[:id]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * FROM todos WHERE id = #{id}"
  @todo = db.exec(sql).first
  db.close
    erb :todo
end



post '/todos/todo/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "DELETE FROM todos WHERE id = #{id}"
  db.exec(sql)
  db.close
  redirect to "/todos"
end








