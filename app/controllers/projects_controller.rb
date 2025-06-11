class ProjectsController < ApplicationController

  before_action :set_project, only: [:show, :update_status, :add_comment]

  def set_project
    @project = Project.find(params[:id])
  end

  def index
    @projects = current_user.projects.order(created_at: :desc)
  end

  def show
    @project_event = ProjectEvent.new
    @events = @project.project_events.includes(:user).order(created_at: :desc)
  end

  def update_status
    old_status = @project.status
    if @project.update(status: params[:status])
      @project.project_events.create!(
        user: current_user,
        event_type: :status_change,
        content: "Status changed from #{old_status} to #{params[:status]}",
        from_status: old_status,
        to_status: @project.status
      )

      redirect_to @project, notice: 'Project status updated successfully.'
    else
      flash.now[:alert] = 'Failed to update project status.'
      render :show
    end
  end

  def add_comment
    @project.project_events.create!(
      user: current_user,
      event_type: :comment,
      content: params[:project_event][:content]
    )

    redirect_to @project, notice: 'Comment added successfully.'
  rescue StandardError => e
    flash.now[:alert] = "An error occurred: #{e.message}"
    render :show
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end
end
