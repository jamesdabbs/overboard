class StaticController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:root]

  def root
    redirect_to courses_path if current_user
  end
end
