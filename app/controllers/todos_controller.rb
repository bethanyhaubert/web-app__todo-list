MyApp.before "/todos*" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user == nil
  erb :"logins/denied_access"
	end
end

MyApp.get "/" do
	@todo_list =  Todo.all
	@current_user = User.find_by_id(session["user_id"])
  erb :"index"
end

MyApp.post "/todos/complete" do
	Todo.set_as_complete(params["set_completed_todos"])
  redirect :"/"
end

MyApp.get "/todos/new" do
  erb :"todos/new"
end

MyApp.post "/todos/create" do
	todo = Todo.new
	todo.title = params[:title]
	todo.description = params[:description]
	todo.completed = false
	todo.user_id = @current_user.id

	if todo.is_valid == true
		todo.save
  redirect :"todos/#{todo.id}/details"

	else
		@error_object = todo
  erb :"error"
	end

end

MyApp.get "/todos/:todo_id/details" do
	@todo = Todo.find(params[:todo_id])
  erb :"todos/details"
end

MyApp.post "/todos/:todo_id/edit" do
	@todo = Todo.find(params[:todo_id])
	@todo.assign_attributes({title: params['title'], description: params['description']})
	@todo.user_id = @current_user.id

	if @todo.is_valid == true
		@todo.save
  redirect :"todos/#{@todo.id}/details"

	else
		@error_object = @todo
  erb :"error"
	end

end

MyApp.post "/todos/:todo_id/delete" do
	@todo = Todo.find(params[:todo_id])
	@todo.delete
  redirect :"success"
end



