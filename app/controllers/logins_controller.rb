MyApp.post "/logins/create" do
  @user = User.find_by_email(params["email"])

  if params["password"] != nil
    if @user.password == params["password"]
      session["user_id"] = @user.id
      session["temporary_error_message"] = nil
     redirect "users/#{@user.id}/profile"
    else
      session["temporary_error_message"] = "Incorrect login information"
     redirect "/"
    end
  else
      session["temporary_error_message"] = "Please create a new account"
     redirect "/"
   end
end

MyApp.get "/logins/sign_out" do
  session["user_id"] = nil
 erb :"success"
end