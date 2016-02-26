class Todo < ActiveRecord::Base


    #Finds that Category name associated with this Todo object's id
  #
  # Returns that Category objects name
  def assignee_name
    user = User.find_by_id(self.user_id)
    return user.name
  end

  #Finds that Category name associated with this Todo object's id
  #
  # Returns that Category objects name
  def category_name
    category = Category.find_by_id(self.category_id)
    return category.name
  end

#Finds the User object related to this Todo object
#
#Returns the name of the User object
 def who_assigned_this_todo
  assigner = User.find_by_id(self.added_by)
  return assigner.name
 end
#this method sets all todos to not completed
#
#returns nil
 def Todo.set_all_todos_completed_to_false
  all_todos = Todo.all
  all_todos.each do |todo|
      todo.completed = false
      todo.save
   end
 end

  #this method enters todos as completed
  #
  #
  #returns nil
  def Todo.set_as_complete(arr_of_todos)
    Todo.set_all_todos_completed_to_false
      arr_of_todos.each do |todo|
          this_todo= Todo.find_by_id(todo)
          this_todo.completed = true
          this_todo.save
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

    	if self.title == ""
      	@errors << "Title cannot be blank"
    	end

      if self.user_id == nil
        @errors << "Must assign to a user"
      end

      if self.category_id == nil
        @errors << "Must assign to a category"
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
