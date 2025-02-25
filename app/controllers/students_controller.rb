class StudentsController < ApplicationController
  def index
    # Mock data for demonstration
    mock_students = [
      { name: "John", last_name: "Doe", specialty: "Computer Science", email: "john.doe@example.com", alternate_email: "", phone_number:"1234567890123"  },
      { name: "Jane", last_name: "Smith", specialty: "Software Engineering", email: "jane.smith@example.com", alternate_email: "" ,phone_number:"1234567890123" },
      { name: "Alice", last_name: "Johnson", specialty: "Data Science", email: "alice.johnson@example.com", alternate_email: "" ,phone_number:"" },
      { name: "Bob", last_name: "Brown", specialty: "Mathematics", email: "bob.brown@example.com", alternate_email: "bob.alt@example.com", phone_number:"1234567890123" },
      { name: "Charlie", last_name: "Davis", specialty: "Physics", email: "charlie.davis@example.com", alternate_email: "", phone_number:"1234567890123" },
      { name: "Eve", last_name: "Williams", specialty: "Chemistry", email: "eve.williams@example.com", alternate_email: "", phone_number:"1234567890123" },
      # Add more students as needed
    ]

    # Paginate using Kaminari
    @students = Kaminari.paginate_array(mock_students).page(params[:page]).per(5) # Adjust the per page limit as required
  end
end