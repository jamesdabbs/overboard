class WeeksController < ApplicationController
  before_action :find_week, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    days, attrs = week_params.partition { |k,_| Week.lecture_days.include? k }
    attrs.each { |k,v| @week.set k,v }
    days.each do |dayname, attrs|
      attrs.each { |k,v| @week.day(dayname).set k,v }
    end
    @week.save!
    redirect_to course_week_path(@course, @week.number)
  end

private

  def find_week
    @course = Course.find params[:course_id]
    @week   = @course.week params[:number]
    authorize @week
  end

  def week_params
    days = Week.lecture_days.map { |n| [n, [:description, :summary]] }.to_h
    params.require(:week).permit(:goals, :plans, :project, days)
  end
end
