class TasklistsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :create]
  
  def create
    @task = current_user.tasks.build(tasks_params)
    if @task.save
      flash[:success] = 'タスクを保存しました。'  
      erdirecu_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの保存に失敗しました。'
      render 'users/index'
    end
  end

  def destroy
    @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def task_params
    params.require( :task ).permit( :user_id, :content, :status )
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
