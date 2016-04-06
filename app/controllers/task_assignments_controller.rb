class TaskAssignmentsController < ApplicationController

  def create
    @task = Task.find_by_id params[:task_id]
    @user = current_user
    @user.tasks << @task
    @sprint = @task.sprint
    @task.start!
    respond_to do |format|
      format.html {redirect_to sprint_tasks_path(@sprint)}
      format.js { render :pick }
    end
  end

  def destroy
    @task = Task.find_by_id params[:id]
    @user = current_user
    @user.tasks.destroy(@task)
    if @task.users == []
      @task.go_back!
    end
    respond_to do |format|
      format.html {redirect_to sprint_tasks_path(@task.sprint)}
      format.js { render :leave }
    end


  end

end
