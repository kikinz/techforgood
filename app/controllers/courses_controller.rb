class CoursesController < ApplicationController
  # Shows all courses on the home page
  def index
    @courses = Course.all
  end

  # Shows all the information for one course
  def show
    @course = Course.find(params[:id])
  end

  # To add a new course for an organization
  def new
    @organization = Organization.find(params[:organization_id])
    @course = Course.new
  end

  def create
    # creating a new course with the parameters from the form
    @course = Course.new(course_params)
    
    # find the organization the course is being made for
    @organization = Organization.find(params[:organization_id])
    
    # assigning the course to an organization
    @course.organization = @organization
    @course.save

    redirect_to course_path
  end

  # To edit a course
  def edit
    @course = Course.find(params[:id])
  end
  
  def update
    # find the course from the edit form
    @course = Course.find(params[:id])

    # updating and saving the course details
    @course.update(course_params)
    @course.save

    redirect_to course_path
  end

  # To delete a course
  def destroy
    @course = Course.find(params[:id])
    @course.delete
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :organization_id)
  end
end