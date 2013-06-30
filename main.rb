require 'pry'
require 'sinatra'
require 'rainbow'
require 'pg'
require 'sinatra/reloader' if development?

#run sql database
# def run_sql(sql)
#   db = PG.connect(:dbname => 'to_do', :host => 'localhost')
#   #result = db.exec(sql)
#   db.close
#   #Return whatever needs to happen now
# end
get '/' do
  redirect to('/todos')
end
# List todo items
get '/todos' do
 puts ": Database opened".color(:blue)
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * FROM todos"
  @todos = db.exec(sql)
  puts ":: todos pulled from database".color(:yellow)
  db.close
  puts "::: Database now closed".color(:magenta)
  erb :todos
end

# Show the details of a todo
get '/todos/todo/:id' do

  id = params[:id]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * FROM todos WHERE id = #{id}"
  @todo = db.exec(sql)[0]
  db.close

  	erb :todo
end

# #Go to form to create new task in todo table
get '/todos/new_todo' do
  erb :new_todo
end

# Create a todo by sending a POST request to this URL
post '/todos' do
  task = params[:task]
  due = params[:due]
  priority = params[:priority]
  completed = params[:completed]

  #Info to post from database
  sql = "INSERT INTO todos (task, due, priority, completed) VALUES ('#{task}', '#{due}', #{priority}, #{completed})"

  #connect to database for insertion
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  db.exec(sql)
  db.close
  #This will send you to the newly created todo
  redirect to("/todos")
end

#Get todo id for updating / editing
get '/todos/todo/:id/update' do
  id = params[:id]
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * from todos WHERE id = #{id}"
  @todo = db.exec(sql).first
  db.close

  erb :update
end

#POST updated todo/:id
post '/todos/todo/:id' do

  id = params[:id]
  task = params[:task]
  due = params[:due]
  priority = params[:priority]
  completed = params[:completed]

  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  puts ": Database opened".color(:blue)

  sql = "UPDATE todos SET (task, due, priority, completed) = ('#{task}', '#{due}', #{priority}, #{completed}) WHERE id = #{id}"

  db.exec(sql)
  puts ":: todo updated in database".color(:yellow)
  db.close
  puts "::: Database closed".color(:magenta)

  redirect to('/todos')
end


