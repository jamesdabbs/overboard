require 'rails_helper'

describe Course do
  before :each do
    @course = create :course
  end

  it "has weeks" do
    expect(@course.weeks.count).to eq 12
  end

  it "has days inside weeks" do
    week   = @course.weeks.sample
    expect(week.days.count).to eq 4
    expect(week.days.map &:name).to eq ["Monday", "Tuesday", "Wednesday", "Thursday"]
  end

  it "can update weeks" do
    @course.week(2).plans = "Models"
    expect(@course.week(2).plans).to eq "Models"
    @course.save!

    @course.reload
    expect(@course.week(2).plans).to eq "Models"
  end

  it "can update days" do
    @course.week(2).day("Wednesday").summary = "HTTParty"
    expect(@course.week(2).day("Wednesday").summary).to eq "HTTParty"
    @course.save!

    @course.reload
    expect(@course.week(2).day("Wednesday").summary).to eq "HTTParty"
  end

  it "fails lookups gracefully" do
    expect(@course.week(4).day("Tuesday").summary).to eq nil
  end

  it "can set data on projects" do
    @course.week(3).project.summary = "Gettin' Piggy with It"
    expect(@course.week(3).project.summary).to eq "Gettin' Piggy with It"

    @course.week(3).project.description = "Gettin' Piggy with It"
    expect(@course.week(3).project.description).to eq "Gettin' Piggy with It"
  end
end
