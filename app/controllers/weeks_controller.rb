class WeeksController < ApplicationController
  def show
    @course = Course.find params[:course_id]
    @week   = @course.week params[:number]
    authorize @week
  end
end
