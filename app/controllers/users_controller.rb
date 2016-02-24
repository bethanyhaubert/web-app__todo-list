MyApp.get "/users/create_user" do
  erb :"users/create_user"
end

MyApp.post "/add_user" do
	@user = User.new
	@user.name = params[:name]
	@user.email = params[:email]
	@user.password = params[:password]
	# if @user.is_valid == true
	 	@user.save
	# 	redirect :"profile/#{@user.id}"
	# else
	# 	@error_object = @user
	# 	erb :"error"
	# end
	redirect :"profile/#{@user.id}"
end

MyApp.get "/profile/:user_id" do
  	@user = User.find(params[:user_id])
  erb :"users/profile"
end

MyApp.post "/edit_user/:user_id" do
	@user = User.find(params[:user_id])
	@user.assign_attributes({name: params['name'], email: params['email'], password: params['password']})
	# if @user.is_valid == true
		@user.save
	# 	redirect :"profile/#{@user.id}"
	# else
	# 	@error_object = @user
	# 	erb :"error"
	# end
  redirect :"profile/#{@user.id}"
end

MyApp.post "/user_delete/:user_id" do
	@user = user.find(params[:user_id])
	@user.delete
  erb :"success"
end
