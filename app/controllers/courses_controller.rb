class CoursesController < ApplicationController
  def index
    @courses = policy_scope(Course).includes :campus, :instructor, :topic
  end

  def show
    @course = Course.find params[:id]
    authorize @course
  end

  def new
    @course = Course.new
    authorize @course
  end

  def create
    @course = Course.new create_params
    authorize @course
    if @course.save
      redirect_to @course, success: "Course saved!"
    else
      render :new
    end
  end

private

  def create_params
    params.require(:course).permit(:instructor_id, :campus_id, :topic_id, :start_on)
  end
end
