require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from todo"
  @todos = db.exec(sql)
  db.close
  
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from todo where id = '#{@id}'"
  @todo = db.exec(sql).first
  db.close

 	erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  #This will send you to the newly created todo
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  #@completed = params[:completed]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "insert into todo (name,description,date) values ('#{@name}','#{@description}','#{@date}')"# #{@completed}"
  db.exec(sql)
  db.close
  redirect to("/")
end

get '/todo/:id/edit' do
   erb :edit
end

post '/todo/:id/delete' do

end
