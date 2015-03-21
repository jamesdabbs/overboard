class StudentsController < ApplicationController
  before_action :find_course

  def index
    @students = policy_scope(@course.students)
  end

  def new
    @teams = current_user.github_teams
    authorize @course.students.new
  end

  def create
    authorize @course.students.new
    @course.import_students current_user.octoclient, params[:team][:id]
    redirect_to course_students_path(@course), notice: "Students imported"
  end

private

  def find_course
    @course = Course.find params[:course_id]
  end
end
