require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
#  db = PG.connect(:dbname => 'sinatra_to_do', :host => 'localhost')
# sql = "SELECT * from todo"
# @todo = db.exec(sql)
# db.close
  erb :todos
end

get '/list' do
db = PG.connect(:dbname => 'sinatra_to_do', :host => 'localhost')
sql = "SELECT * from todo"
@todo = db.exec(sql)
db.close
erb :todo
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
end

# create todo
get '/create_todo' do
# db = PG.connect(:dbname => 'sinatra_to_do', :host => 'localhost')
# sql = "SELECT * from todo"
# @todo = db.exec(sql)
# db.close
erb :create_todo
end

post '/create_todo' do
  to_do = params[:todo]
  due_date = params[:due_date]
  has_it_been_completed = params[:has_it_been_completed]
  db = PG.connect(:dbname => 'sinatra_to_do', :host => 'localhost')
  sql = "INSERT INTO todo (to_do, due_date,has_it_been_completed) VALUES ('#{to_do}','#{due_date}','#{has_it_been_completed}')"
  db.exec(sql)
  db.close
  redirect to '/list'
end

get '/list/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'sinatra_to_do', :host => 'localhost')
   sql = "SELECT * FROM todo WHERE id = #{id}"
  @contact = db.exec(sql).first
  db.close
  erb :edit
end

# Create a todo by sending a POST request to this URL
# post '/create_todo' do
#   #This will send you to the newly created todo
#   redirect to("/todo/#{id}")
# end
