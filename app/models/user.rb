class User < ActiveRecord::Base
  #Collects all of the to-dos added or edited most recently by this user
  #
  #Returns an array
  def todos_by_user
    list_todos = Todo.where({"user_id" => self.id})
    if list_todos.empty?
      return nil
    else
      return list_todos
    end
  end


		#Returns @errors
  	def get_errors
    	return @errors
 	end

  	#Adds errors to Hash
  	#
  	#Returns Hash
  	def set_errors
    	@errors = []

    	if self.name == ""
      	@errors << "Name cannot be blank"
    	end

    	if self.email == ""
      	@errors << "Email cannot be blank"
    	end

      if User.exists?(email: [self.email]) == true
        @errors << "An account already exists for this email address."
      end

    	if self.password == ""
      	@errors << "Must choose a password"
    	end
  	end

  # Checks if the record is valid.
  # 
  # Returns Boolean.
  	def is_valid
    	self.set_errors
    	if @errors.length > 0
      	return false
    	else
      	return true
    	end
  	end
end