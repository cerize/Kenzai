class TaskAssignmentsController < ApplicationController

  def create
    @task = Task.find_by_id params[:task_id]
    @user = current_user
    @user.tasks << @task
    @sprint = @task.sprint
    respond_to do |format|
        format.js { render :pick }
    end
  end

  def destroy
    @task = Task.find_by_id params[:id]
    @user = current_user
    @user.tasks.destroy(@task)
    respond_to do |format|
      format.js { render :leave }
    end


  end

end
