require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items

get '/' do

erb :index
end

get '/todos' do

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
  name = params[:name]
  description = params[:description]
  sql = "Insert into to_do(name, description) VALUES ('#{name}', '#{description}')"
  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to("/todos/#{id}")
end

post '/todos/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  sql = "DELETE FROM to_do WHERE id = #{id}"
  @to_do = db.exec(sql).first
  db.close
  redirect to '/todos'
end

get '/todos/:id/edit' do
  @id = params[:id]
  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  sql = "SELECT * FROM to_do WHERE id = #{@id}"
  @to_do = db.exec(sql).first
  db.close
  erb :edit
end

# Show the details of a todo
get '/todos/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'errands', :host => 'localhost')
  sql = "SELECT * FROM to_do WHERE id = #{@id}"
  @to_do = db.exec(sql).first
  db.close
  	erb :todo
end
