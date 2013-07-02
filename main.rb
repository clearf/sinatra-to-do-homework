require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# Root page with a link to the current To Do list
get '/' do
  erb :index
end

# Current list of to do's pulled from the db
get '/todos' do
  db = PG.connect(:dbname => 'to_dos', :host => 'localhost')
  sql = "select * from todo"
  @to_dos = db.exec(sql)
  db.close
    erb :todos
  end

# Show the details of a todo
get '/todo/:id' do
  id = params[:id]
  db = PG.connect(:dbname => 'to_dos', :host => 'localhost')
  sql = "select * from todo where id = #{id}"
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
  activity = params[:activity]
  sql_query="INSERT into todo(activity) VALUES ('#{activity}')"
  # Open database
@todo = db.exec(sql_query)
#  Where to pass this to??
# We don't know exactly if we can get the id
  sql = "SELECT * from to_dos WHERE (activity = ('#{activity}')"
    #@new_todos = new_todos(sql).first
    #id = @todo['id']
  #This will send you to the newly created todo
  # False assurance of uniquity.  BAD!!!
  # Query to access the ID we just inserted. GOOD!!!
  #redirect to("/todo/#{id}")
  # OR redirect to the index ('/')
  redirect to("/")
end
