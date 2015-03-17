class CoursesController < ApplicationController
  def index
    @courses = current_user.courses
    @active  = current_user.active_course
  end

  def show
    @course = current_user.courses.find params[:id]
  end
end
