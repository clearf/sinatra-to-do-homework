require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# creating function to enter sql code more easily
helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'address_book', :host => 'localhost')
    result = db.exec(sql)
    db.close
    # make sure the return doesn't screw things up
    return result
  end
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
