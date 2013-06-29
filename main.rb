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
  id = params[:id]
  @task = run_sql("SELECT * FROM todolist WHERE id = #{id}").first
  erb :todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  @task = params[:task]
  @notes = params[:notes]
  run_sql("INSERT INTO todolist (task, notes, done) VALUES ('#{@task}', '#{@notes}', false)")
  redirect to("/")
end

get '/edit/:id' do
  @id = params[:id]
  @task = run_sql("SELECT * FROM todolist WHERE id = #{@id}").first

  erb :edit
end

post '/edit/:id' do
  id = params[:id]
  task = params[:task]
  notes = params[:notes]
  done = params[:done]
  run_sql("UPDATE todolist SET (task, notes, done) = ('#{task}', '#{notes}', '#{done}') WHERE id = #{id}")

  redirect to("/todo/#{id}")
end

post '/delete/:id' do
  id = params[:id]
  run_sql("DELETE FROM todolist WHERE id = #{id}")

  redirect to('/')
end


