require 'pry'
require 'sinatra'
require 'rainbow'
require 'pg'
require 'sinatra/reloader' if development?

#run sql database
def run_sql(sql)
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  #result = db.exec(sql)
  db.close
  #Return whatever needs to happen now
end

# List todo items
get '/' do
 puts ": Database opened".color(:blue)
  db = PG.connect(:dbname => 'to_do', :host => 'localhost')
  sql = "SELECT * FROM todos"
  @todos = db.exec(sql)
  puts ":: @todos pulled from database".color(:yellow)
  db.close
  puts "::: Database now closed".color(:magenta)
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
end

# create todo
get '/new_todo' do
  erb :new_todo
end

# Create a todo by sending a POST request to this URL
post '/new_todo' do
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end
