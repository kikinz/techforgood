class SessionsController < ApplicationController
  # Devise authentication exceptions for the following pages:
  # skip_before_action :authenticate_user!, only: [:index, :show]

  # Devise: whitelist all pages for testing
  skip_before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  #shows the status of lessons on the user dashboard
  def show
    @session = Session.find(params[:id])
  end

  #marks a lesson as started on the user dashboard
  def create
    @lesson = Lesson.find(params[:lesson_id])
    @session = @lesson.sessions.new(session_params)
    @session.user = current_user
    @session.save
  end

  #updates the lesson status on the user dashboard as the student completes lessons
  def update
    @session = Session.find(params[:id])
    @session.update(session_params)
  end

  private

  def session_params
    params.require(:session).permit(:status, :user_id, :lesson_id)
  end
end
