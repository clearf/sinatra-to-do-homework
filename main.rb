require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

# function to connect to the to_do_list database
def get_todos(sql_input)
  db = PG.connect(:dbname => 'to_do_list', :host => 'localhost')
  result = db.exec(sql_input)
  db.close
  result
end

# This should be the home/root
get '/' do
  erb :home
end

# This should list todos
get '/todo' do
  sql_input = "SELECT * FROM to_dos"
  get_todos(sql_input)
  @todos = get_todos(sql_input)
  erb :todos
end

# This should show the details of a todo
get '/todo/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM to_dos WHERE id = #{id}"
  @todo = get_todos(sql_input).first
  erb :todo
end

# This should create a todo
get '/create_todo' do
  erb :create_todo
end

# This should create a todo by sending a POST request to this URL
post '/create_todo' do
  task = params[:task]
  due_date = params[:due_date]
  sql_input = "INSERT INTO to_dos (task, due_date, accomplished) VALUES ('#{task}', '#{due_date}', false)"
  get_todos(sql_input)
  sql_input = "SELECT * FROM to_dos WHERE (task, due_date) = ('#{task}', '#{due_date}')"
  @todo = get_todos(sql_input).first
  id = @todo['id']
  #This will send you to the newly created todo
  redirect to("/todo/#{id}")
end

# This should find the todo information to edit
get '/todo/:id/edit' do
  id = params[:id]
  sql_input = "SELECT * FROM to_dos WHERE id = #{id}"
  @todo = get_todos(sql_input).first
  erb :edit
end

# This should send a post request
post '/todo/:id' do
  id = params[:id]
  task = params[:task]
  due_date = params[:due_date]
  accomplished = params[:accomplished]
  if accomplished == 'yes'
    accomplished = true
  else
    accomplished = false
  end
  sql_input = "UPDATE to_dos SET (task, due_date, accomplished) = ('#{task}', '#{due_date}', #{accomplished}) WHERE id = #{id}"
  get_todos(sql_input)
  redirect to('/todo')
end

# This should delete the task
post '/todo/:id/delete' do
  id = params[:id]
  sql_input = "DELETE FROM to_dos WHERE id = #{id}"
  get_todos(sql_input)
  redirect to('/todo')
end

