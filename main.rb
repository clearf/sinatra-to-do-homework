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


# Create a todo by sending a POST request to this URL
post '/' do
  id = params[:id]
  task = params[:task]
  task_description = params[:task_description]
  completed = params[:completed]
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "insert into to_do_list (task, task_description, completed) values ('#{task}', '#{task_description}', #{completed})"
  @todos = db.exec(sql)
  db.close
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end

post '/todo/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "delete from to_do_list where id = #{id}"
  db.exec(sql)
  db.close
  redirect to "/"
end

get '/todo/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "select * from to_do_list where id = #{id}"
  @todo = db.exec(sql).first
  db.close
  erb :edit
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Show the details of a todo
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "select * from to_do_list where id =#{id}"
  @todo = db.exec(sql).first
  puts "closing the database"
  db.close
  erb :todo
end


post '/todo/:id' do
  id = params[:id]
  task = params[:task]
  task_description = params[:task_description]
  completed = params[:completed]
  db = PG.connect(:dbname => 'hw_sinatra', :host => 'localhost')
  sql = "update to_do_list set (task, task_description, completed) = ('#{task}', '#{task_description}',#{completed}) WHERE id = #{id}"
  db.exec(sql)
  db.close
end
