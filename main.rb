require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'todo', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
  erb :index
end

# List todo items
get '/todos' do
  sql = "SELECT * FROM tasks"
  @todos = run_sql(sql)
  erb :todos
end

# # Show the details of a todo
# get '/todo/:id' do
#   	erb :todo
# end

# create todo
get '/create_todo' do
  erb :new_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  #This will send you to the newly created todo
  task = params[:task_name]
  description = params[:description]
  date = params[:due_date]
  urgency = params[:urgent]
    if urgency == 'on'
      urgency = true
    else
      urgency = false
    end
  sql = "INSERT INTO tasks (task, description, due_date, urgency) VALUES ('#{task}', '#{description}', #{date}, #{urgency})"
  run_sql(sql)
  redirect to '/todos'
  # redirect to("/todo/#{id}")
end
