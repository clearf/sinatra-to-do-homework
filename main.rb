require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# function to connect to the to_do_list database
def get_todos(sql_input)
  db = PG.connect(:dbname => 'to_do_list', :host => 'localhost')
  result = db.exec(sql_input)
  db.close
  result
end

get '/' do
end

# List todo items
get '/todo' do
  sql_input = "SELECT * from to_dos"
  get_todos(sql_input)
  @todos = get_todos(sql_input)
  erb :todos
end

# # Show the details of a todo
get '/todo/:id' do
  id = params[:id]
  sql_input = "SELECT * from to_dos WHERE id = #{id}"
  @todo = get_todos(sql_input).first
  erb :todo
end

# # create todo
# get '/create_todo' do
#   erb :create_todo
# end

# # Create a todo by sending a POST request to this URL
# post '/create_todo' do
#   #This will send you to the newly created todo
#   redirect to("/todo/#{id}")
# end
