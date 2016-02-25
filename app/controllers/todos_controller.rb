MyApp.before "/todos*" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user == nil
 		@error_object = "You must login first"
  redirect "/"
	end
end

MyApp.get "/" do
	@todo_list =  Todo.all
	@category_list = Category.all
	@current_user = User.find_by_id(session["user_id"])
  erb :"index"
end

MyApp.post "/todos/complete" do
	Todo.set_as_complete(params["set_completed_todos"])
  redirect "/"
end

MyApp.get "/todos/new" do
	@list_users = User.all
	@category_list = Category.all
  erb :"todos/new"
end

MyApp.post "/todos/create" do
	todo = Todo.new
	todo.title = params[:title]
	todo.description = params[:description]
	todo.completed = false
	todo.user_id = params[:user_id]

	assigner = Assigner.new
	assigner.user_id = @current_user.id

	if todo.is_valid == true
		todo.save
  redirect "todos/#{todo.id}/details"

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
	@todo.assign_attributes({title: params['title'], description: params['description'], user_id: params['user_id']})

	if @todo.is_valid == true
		@todo.save
  redirect "todos/#{@todo.id}/details"

	else
		@error_object = @todo
  erb :"error"
	end

end

MyApp.post "/todos/:todo_id/delete" do
	@todo = Todo.find(params[:todo_id])
	@todo.delete
  erb :"success"
end



