MyApp.get "/" do
	@todo_list =  Todo.all
	@current_user = User.find_by_id(session["user_id"])
  erb :"index"
end


MyApp.get "/todos/new" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user != nil
  		erb :"todos/new"
	else
  		erb :"logins/denied_access"
	end
end

MyApp.post "/add_todo" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user != nil

	todo = Todo.new
	todo.title = params[:title]
	todo.description = params[:description]
	todo.completed = false
	todo.user_id = @current_user.id

		if todo.is_valid == true
			todo.save
	  		redirect :"todo_info/#{todo.id}"
		else
			@error_object = todo
			erb :"error"
		end
	else
	erb :"logins/denied_access"
	end
end

MyApp.get "/todo_info/:todo.id" do
	@todo = Todo.find_by_id(params[:todo_id])
	erb :"todo_info/#{@todo.id}"
end

MyApp.post "/edit_todo/:todo_id" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user != nil
	@todo = Todo.find(params[:todo_id])
	@todo.assign_attributes({title: params['title'], description: params['description']})
	@todo.user_id = @current_user.id
		if @todo.is_valid == true
			@todo.save
	  		redirect :"todo_info/#{@todo.id}"
		else
			@error_object = @todo
			erb :"error"
		end
	else
	erb :"logins/denied_access"
	end	
end