require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# Method to open and access the existing data base
def access_todo_db
  db_accessed = PG.connect(
    :dbname => 'todo_homework',
    :host => 'localhost')
  db_accessed.close
  return db_accessed
end

# sql_input = "INSERT INTO contacts (first, last, age, gender, dtgd, phone) VALUES ('#{@first}', '#{@last}', '#{@age}', '#{@gender}', '#{@dtgd}', '#{@number}')"

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
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end
