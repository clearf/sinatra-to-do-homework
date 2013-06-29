require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require 'rainbow'

# creating function to enter sql code more easily
# had difficulty getting run_sql function to work
helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'todo', :host => 'localhost')
    db.exec(sql)
    db.close
    # make sure the return doesn't screw things up
    return result
  end
end

# List todo items
get '/' do
  # setting up database connection for main page - displaying full list
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @show_db = 'select * from list'
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  # setting up database connection for task page - displaying item with certain id
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @id = params[:id]
  @item = "select * from list where id = #{params[:id]}"
  erb :todo
end

# create todo
get '/create_todo' do
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  # setting up variables to add item to list
  @task = params[:task]
  @description = params[:description]
  @do_by = params[:do_by]
  @done = params[:done]
  # add item to list using variables
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  add = "insert into list (task, description, do_by, done) values ('#{@task}', '#{@description}', '#{@do_by}', '#{@done}')"
  db.exec(add)
  # call id for the task from database
  find_id = "select id from list where task = '#{@task}'"
  id = db.exec(find_id).values[0][0]
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end

get '/delete_todo' do
  # setting up database connection for main page - displaying full list
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @show_db = 'select * from list'
  erb :delete_list
end

get '/delete_todo/:id' do
  # setting up database connection for task page - displaying item with certain id
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @id = params[:id]
  @item = "select * from list where id = #{@id}"
  erb :delete_todo
end

post '/delete_todo/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  delete = "delete from list where id = '#{@id}'"
  db.exec(delete)
  redirect to('/')
end

get '/update_todo' do
  # setting up database connection for main page - displaying full list
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @show_db = 'select * from list'
  erb :update_list
end

get '/update_todo/:id' do
  @db = PG.connect(:dbname => 'todo', :host => 'localhost')
  @id = params[:id]
  @item = "select * from list where id = #{@id}"
  erb :update_todo
end

post '/update_todo/:id' do
  # setting up variables to add item to list
  @task = params[:task]
  @description = params[:description]
  @do_by = params[:do_by]
  @done = params[:done]
  id = params[:id]
  # add item to list using variables
  db = PG.connect(:dbname => 'todo', :host => 'localhost')
  update = "update list set task='#{@task}', description='#{@description}', do_by='#{@do_by}', done='#{@done}' where id=#{id}"
  db.exec(update)
  #This will send you to the newly updated todo
  redirect to("/todo/#{id}")
end


