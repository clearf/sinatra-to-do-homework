require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  db= PG.connect(:dbname => 'organizer', :host => 'localhost')
  sql= "SELECT * FROM todo"
  @todos = db.exec(sql)
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  @item_id = params[:id]
  db= PG.connect(:dbname => 'organizer', :host => 'localhost')
  sql= "SELECT * FROM todo WHERE id ='#{@item_id}'"
  @item_details = db.exec(sql).first
  db.close
    erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  @description = params[:description]
  @due = params[:due]
  @completed = params[:completed]
  db= PG.connect(:dbname => 'organizer', :host => 'localhost')
  sql= "INSERT INTO todo (description, due, completed) VALUES ('#{@description}','#{@due}','#{@completed}')"
  db.exec(sql)
  db.close
  #This will send you to the newly created todo
  redirect to("/")
end

post '/todo/:id/delete' do
  @id = params[:id]
  db = PG.connect(:dbname => 'organizer', :host => 'localhost')
  sql = "DELETE FROM todo WHERE id= #{@id}"
  db.exec(sql)
  db.close
  redirect to "/"
end




