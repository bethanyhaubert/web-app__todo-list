MyApp.before "/categories*" do
	@current_user = User.find_by_id(session["user_id"])
	if @current_user == nil
  		session["temporary_error_message"] = "You must login first"  
  	redirect "/"
	end
end

MyApp.get "/categories/new" do
  erb :"categories/new"
end

MyApp.post "/categories/create" do
	category = Category.new
	category.name = params[:name].capitalize

	if category.is_valid == true
		category.save
  redirect "categories/#{category.id}/details"

	else
		@error_object = category
  erb :"error"
	end

end

MyApp.get "/categories/:category_id/details" do
	@category = Category.find(params[:category_id])
  erb :"categories/details"
end

MyApp.post "/categories/:category_id/edit" do
	@category = Category.find(params[:category_id])
	@category.assign_attributes({name: params['name']})

	if @category.is_valid == true
		@category.save
  redirect "categories/#{@category.id}/details"

	else
		@error_object = @category
  erb :"error"
	end

end

MyApp.post "/categories/:category_id/delete" do
	@category = Category.find(params[:category_id])
	@category.delete
  erb :"success"
end