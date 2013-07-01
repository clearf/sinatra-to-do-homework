require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
end

get '/todo/:id/edit' do
	# do this:
	# query the database for the 
	# id params[:id] and then
	# set that record equal to 
	# @todo instance variable

	# We've put a hack in the ERB
	# file to let us edit 
  	erb :create_todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  todo_name=params[:todo_name]
  description=params[:description]
  sql_query="insert into todo (todo_name, description) 
  values ('#{todo_name}', '#{description}')"
  # XXX todo: open database
  # db = pg.connect...
  db.exec(sql_query)
  # XXX todo: close database
  # This will send you to 
  # the newly created todo
  # Get maximum ID in the database
  # Can you just query the DB for the todo item that 
  # matches name, description?
  # Due date. 
  # **False assurance of uniquity. BAD!**
  # Query to access the ID we just inserted. Good
  # ** False assurance of staticness. BAD **
  # 	Hack: this is a hack: Someone might have added
  # records
  # new_id = select max(id) from todos; 
  # We don't know exactly if we can get the id returned from 
  # our insert into. We will research. 
  # Just redirct to the "index" page
  # redirect to("/todo/#{id}")
  redirect to("/")
end
