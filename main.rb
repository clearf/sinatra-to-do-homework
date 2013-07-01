require 'pry'
#for debugging

require 'sinatra'
#sinatra is the code-glue that link ruby to html

require 'pg'
#gem

require 'sinatra/reloader' if development?
#if development is optional? :means what

# index
get '/' do
  #this prints to sinatra's server
  puts "LET'S TAKE A LOOK AT WHAT YOU HAVE TO DO!"

  erb :todos
end

#List todo items
get '/todos' do
  puts "Please find your list below!"
  db = PG.connect (:dbname => 'todos' :host => 'localhost')
  sql = "SELECT * FROM list"
  @list = db.exec(sql)
  db.close
  puts "database is closed"

  erb :todos
end

post '/todos' do
  todo = params[:id]
  sql = "INSERT into TODOS (todo, description values('#{todo}', '#{description}')"
  db = PG.connect(:dbname => 'todos', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to '/todos'
end


post '/todos/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'todos' :host => 'localhost')
  sql = "Delete from todos where id = #{id}"
  db.exec(sql)
  db.close
  redirect to "/todos"
end

get '/todos/:id/edit' do
  id = params [:id]
  db = PG.connect (:dbname => 'todos' :host => 'localhost')
  sql = "Select * from todos where id = #{id}"
  @list_item = db.exec(sql).first
  db.close
  erb :edit


get '/create_todo' do
  puts "Let's put more on your plate "
  erb :create_todo
end


# Show the details of a todo
get '/todo/:id' do
  todo = params[:id]
  db = PG.connect(:dbname => 'todos' :host => 'localhost')
  sql = "SELECT * FROM todos"
  @list_item = db.exec(sql).first
  db.close
    erb :todo
end

# create todo

# Create a todo by sending a POST request to this URL


post '/todos/:id' do
  id = params[:id]
  task = params[:task]
  description = params[:description]
  db = PG.connect(:dbname => 'todos' :host => 'localhost')
  sql = "Update contacts SET (task, description) = ('#{task}','#{description}') where id = #{id}"
  db.exec(sql)
  db.close
  redirect to '/todos'
end
