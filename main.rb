require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do

  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  sql = "SELECT * FROM to_do"
  @to_do = db.exec(sql)
  db.close
  erb :todos
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

# Show the details of a todo
get '/todo/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  sql = "SELECT * FROM to_do WHERE id = #{id}"
  @to_do = db.exec(sql).first
  db.close
  	erb :todo
end
