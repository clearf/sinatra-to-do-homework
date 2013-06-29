#require 'pry' --> This was giving me a server error. Yeah, it's weird, but it happened.
require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'todo', :host => 'localhost')
    result = db.exec(sql)
    db.close
    return result
  end
end

# List todo items
get '/' do
  @tasks = run_sql("SELECT * FROM todolist")
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  	erb :todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  @task = params[:task]
  @notes = params[:notes]
  run_sql("INSERT INTO todolist (task, notes, done) VALUES ('#{@task}', '#{@notes}', false)")
  redirect to("/")
end
