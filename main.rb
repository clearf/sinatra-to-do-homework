require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?


# List todo items
get '/' do
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from todo"
  @todos = db.exec(sql)
  db.close
  
  erb :todos
end

# Show the details of a todo
get '/todo/:id' do
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "select * from todo where id = '#{@id}'"
  @todo = db.exec(sql).first
  db.close

 	erb :todo
end

# create todo
get '/create_todo' do
  @er = params[:er]
  erb :create_todo
end

# Create a todo by sending a POST request to this URL
post '/create_todo' do
  #This will send you to the newly created todo
  @name = params[:name]
    if @name == ""
      redirect to("/create_todo?er=task_name")
    end
  @description = params[:description]
  @date = params[:date]
  #@completed = params[:completed]
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  sql = "insert into todo (name,description,date) values ('#{@name}','#{@description}','#{@date}')"# #{@completed}"
  db.exec(sql)
  db.close
  redirect to("/")
end

get '/todo/:id/edit' do
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  sql = "select * from todo where id = #{@id}"
  @todo = db.exec(sql).first
  db.close
  erb :edit
end

post '/todo/:id/edit' do
  var = 'f'
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @date = params[:date]
  @completed = params[:completed]
    if @completed
      var == 't'
    else
      var == 'f'
    end
  sql = "update todo set (name,description,date,completed) = ('#{@name}','#{@description}','#{@date}','#{var}') where id = #{@id}"
  @todo = db.exec(sql).first
  db.close

  redirect to("/")
end

post '/delete' do
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  @id = params[:id]
  sql = "delete from todo where id = #{@id}"
  @todo = db.exec(sql)
  db.close
  redirect to("/")
end

post '/complete' do
  db = PG.connect(:dbname => 'Homework',
                  :host => 'localhost',
                  :user => 'postgres',
                  :password => 'postgres')
  @id = params[:id]
  sql = "update todo set completed = 't' where id = #{@id}"
  @todo = db.exec(sql)
  db.close
  redirect to("/")

end
