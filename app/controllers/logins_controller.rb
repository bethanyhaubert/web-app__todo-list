MyApp.post "/logins/create" do
  @user = User.find_by_email(params["email"])

  if @user.password == params["password"]
    session["user_id"] = @user.id

    redirect :"users/#{@user.id}/profile"
  else
  	@todo_list =  Todo.all
  	@error_object = "You must login first"
    redirect :"/"
  end
end

MyApp.get "/logins/sign_out" do
  session["user_id"] = nil
  erb :"success"
end