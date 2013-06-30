require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# Function to connect to/close database and return query result
def sql_query(sql)
  db = PG.connect(:dbname => 'todo_book', :host => 'localhost')
  query_result = db.exec(sql)
  db.close

  return query_result
end

# List todo items
get '/' do
  sql = "SELECT id, title FROM todos"
  @todo_id_title = sql_query(sql)

  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  sql = "SELECT * FROM todos WHERE id = #{params[:id]}"
  @todo_details = sql_query(sql)

  erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create the new do-to by adding it to the database
post '/create_todo' do
  due = params[:due_date] + " " + params[:due_time]
  sql = "INSERT into todos (title, description, due, completed) VALUES ('#{params[:title]}', '#{params[:description]}', '#{due}', 'false')"
  sql_query(sql)

  redirect to('/')
end

# Delete the selected to-do by removing it from the database
post '/delete_todo/:id' do
  sql = "DELETE FROM todos WHERE id = #{params[:id]}"
  sql_query(sql)

  redirect to '/'
end

# Display the selected to-do details
get '/edit_todo/:id' do
  sql = "SELECT * FROM todos WHERE id = #{params[:id]}"
  @todo_details = sql_query(sql)

  erb :edit_todo
end

# Update the selected to-do in the database
post '/edit_todo/:id' do
  due = params[:due_date] + " " + params[:due_time]
  sql = "UPDATE todos SET (title, description, due, completed) = ('#{params[:title]}', '#{params[:description]}', '#{due}', '#{params[:completed]}') WHERE id = #{params[:id]}"
  sql_query(sql)

  redirect to '/'
end












