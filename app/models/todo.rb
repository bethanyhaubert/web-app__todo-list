class Todo < ActiveRecord::Base

#this method sets all todos to not completed
#
#returns nil
 def Todo.set_all_todos_completed_to_false
  all_todos = Todo.all
  all_todos.each do |todo|
      todo.completed = false
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
