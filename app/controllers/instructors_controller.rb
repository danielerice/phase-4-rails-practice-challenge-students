class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

#GET /instructors
def index
    render json: Instructor.all, status: :ok
end

#GET /instructors/:id
def show
    instructor = Instructor.find(params[:id])
    render json: instructor, status: :ok
end

#POST /instructors
def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
end

#PATCH /instructors/:id
def update
    instructor = Instructor.find(params[:id])
    instructor.update!(instructor_params)
    render json: instructor, status: :accepted
end

#DELETE /instructors/:id
def destroy
    instructor = Instructor.find(params[:id])
    instructor.destroy
    head :no_content
end


private

def render_record_not_found_response(invalid)
    render json: {errors: [invalid.record.errors]}, status: :not_found
end

def render_unprocessable_entity_response
    render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity
end

def instructor_params
    params.permit(:name)
end

end
