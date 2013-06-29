require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require 'rainbow'

# creating function to enter sql code more easily
# had difficulty getting run_sql function to work
helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'todo', :host => 'localhost')
    db.exec(sql)
    db.close
    # make sure the return doesn't screw things up
    return result
  end
end

# List todo items
get '/' do
  # setting up database connection for main page - displaying full list
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @show_db = 'select * from list'
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  # setting up database connection for task page - displaying item with certain id
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @item = "select * from list where id = #{params[:id]}"
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
