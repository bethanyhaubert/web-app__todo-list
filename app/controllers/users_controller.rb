MyApp.before "/users/:user_id*" do
	@current_user = User.find_by_id(session["user_id"])
  	@user = User.find_by_id(params[:user_id])
  	if @current_user != nil
  	   erb :"logins/denied_access"
	end
end

MyApp.get "/users/create" do
  erb :"users/create"
end

MyApp.post "/users/new" do
	@user = User.new
	@user.name = params[:name]
	@user.email = params[:email]
	@user.password = params[:password]

	if @user.is_valid == true
	 	@user.save
		redirect :"users/#{@user.id}/profile"
	else
		@error_object = @user
		erb :"error"
	end
end

MyApp.get "/users/:user_id/profile" do
   erb :"users/profile"
end

MyApp.post "/users/:user_id/edit" do
	if @user == @current_user
		@user.assign_attributes({name: params['name'], email: params['email'], password: params['password']})
		if @user.is_valid == true
			@user.save
			redirect :"profile/#{@user.id}"
		else
			@error_object = @user
			erb :"error"
		end
	else
	erb :"logins/denied_access"
	end
end

MyApp.post "/users/:user_id/delete" do
	if @user == @current_user
		@user.delete
  		erb :"success"
  	else
  		erb :"logins/denied_access"
	end
end

MyApp.get "/users/show" do
		@user_list = User.all
  		erb :"users/show"
end