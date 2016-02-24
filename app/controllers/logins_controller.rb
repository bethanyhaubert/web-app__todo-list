MyApp.post "/logins/create" do
  @user = User.find_by_email(params["email"])

  if @user.password == params["password"]
    session["user_id"] = @user.id

    erb :"profile/#{@user.id}"
  else
    erb :"logins/login_failure"
  end
end

MyApp.get "/logins/sign_out" do
  session["user_id"] = nil
  erb :"success"
end