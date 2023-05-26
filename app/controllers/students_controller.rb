class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
    
    #GET /students
    def index
        render json: Student.all, status: :ok
    end
    
    #GET /students/:id
    def show
        render json: Student.find(params[:id]), status: :ok
    end
    
    #POST /students
    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end
    
    #PATCH /students/:id
    def update
        student = Student.find(params[:id])
        student.update!(student_params)
        render json: student, status: :accepted
    end
    
    #DELETE /students/:id
    def destroy
        student = Student.find(params[:id])
        student.destroy
        head :no_content
    end
    
    
    private
    
    def render_record_not_found_response(invalid)
        render json: {errors: "Student not found"}, status: :not_found
    end
    
    def render_unprocessable_entity_response(invalid)
        render json: {errors: "I no make-a the student🤌"}, status: :unprocessable_entity
    end

    def student_params
        params.permit(:name, :major, :instructor_id, :age)
    end
end
