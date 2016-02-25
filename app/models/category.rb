class Category < ActiveRecord::Base

  #This method collects all of the Todo objects that are assigned to this Category object
  #
  #It returns a hash of Todo objects
  def todos_that_belong_to_this_category
    list_of_todos = Todo.where({"category_id" => self.id})
    if list_of_todos != nil
      return list_of_todos
    else
      return nil
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