require 'pry'
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

# Method defined to open and access the existing data base
def access_todo_db
  db_accessed = PG.connect(
    :dbname => 'todo_homework',
    :host => 'localhost')
  # db_accessed.close
  return db_accessed
end

# List all todo items with a link to its details
get '/' do
  @db_accessed = access_todo_db
  @sql_command_show = "SELECT * FROM todolist"
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  @id = params[:id]
  @db_accessed = access_todo_db
  @sql_command_show = "SELECT * FROM todolist WHERE id = #{@id}"

  erb :todo
end

# show the details of a todo for edit
get '/edit/:id' do
  @db_accessed = access_todo_db
  @id = params[:id]

  @sql_command_show = "SELECT * FROM todolist WHERE id = #{@id}"
  @todo_data = @db_accessed.exec(@sql_command_show).first

  erb :edit
end

# Submit data to update the todo
post '/edit/:id' do
  @db_accessed = access_todo_db
  @id = params[:id]
  @todo = params[:todo]
  @note = params[:note]
  @status = params[:status]

  @sql_command_edit = "UPDATE todolist SET (todo, note, status) = ('#{@todo}', '#{@note}', '#{@status}') WHERE id = #{@id}"
  @db_accessed.exec(@sql_command_edit)
  @db_accessed.close

  redirect to("/todo/#{@id}")
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  @todo = params[:todo]
  @note = params[:note]
  @db_accessed = access_todo_db
  @sql_command_add = "INSERT INTO todolist (todo, note, status) VALUES ('#{@todo}', '#{@note}', 'false')"
  @db_accessed.exec(@sql_command_add)

  @sql_command_show = "SELECT * FROM todolist"
  latest_post_index = @db_accessed.exec(@sql_command_show).count - 1
  latest_post_id = @db_accessed.exec(@sql_command_show)[latest_post_index]['id']
  @db_accessed.close

  # #This will send you to the newly created todo
  redirect to("/todo/#{latest_post_id}")
end

# Delete this todo
post '/delete/:id' do
  @db_accessed = access_todo_db
  @id = params[:id]

  @sql_command_delete = "DELETE FROM todolist WHERE id = #{@id}"
  @db_accessed.exec(@sql_command_delete)
  @db_accessed.close
  redirect to "/"
end


