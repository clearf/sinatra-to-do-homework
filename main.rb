require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# function to connect to the to_do_list database
def get_todos(sql_input)
  db = PG.connect(:dbname => 'to_do_list', :host => 'localhost')
  result = db.exec(sql_input)
  db.close
  return result
end

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
