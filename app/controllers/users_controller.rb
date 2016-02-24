MyApp.get "/users/create_user" do
  erb :"users/create_user"
end

MyApp.post "/add_user" do
	@user = User.new
	@user.name = params[:name]
	@user.email = params[:email]
	@user.password = params[:password]
	# if @competitor.is_valid == true
	# 	@competitor.save
	# 	redirect :"profile/#{@competitor.id}"
	# else
	# 	@error_object = @competitor
	# 	erb :"error"
	# end
	erb :"success"
end
