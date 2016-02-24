MyApp.get "/users/create_user" do
  erb :"users/create_user"
end

MyApp.post "/add_user" do
	@user = User.new
	@user.name = params[:name]
	@user.email = params[:email]
	@user.password = params[:password]

	if @user.is_valid == true
	 	@user.save
		redirect :"users/profile/#{@user.id}"
	else
		@error_object = @user
		erb :"error"
	end
end

MyApp.get "/users/profile/:user_id" do
	@current_user = User.find_by_id(session["user_id"])
  	@user = User.find(params[:user_id])
  	if @current_user != nil
   erb :"users/profile"
	else
   erb :"logins/denied_access"
	end
end

MyApp.post "/edit_user/:user_id" do
	@current_user = User.find_by_id(session["user_id"])
	@user = User.find(params[:user_id])
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

MyApp.post "/user_delete/:user_id" do
	@current_user = User.find_by_id(session["user_id"])
	@user = User.find(params[:user_id])
	if @user == @current_user
		@user.delete
  		erb :"success"
  	else
  		erb :"logins/denied_access"
	end
end

MyApp.get "/view_users" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user != nil && @current_user.email == "bethany.haubert@gmail.com"
		@user_list = User.all
  		erb :"users/view_users"
  	else
  		erb :"logins/denied_access"
	end
end