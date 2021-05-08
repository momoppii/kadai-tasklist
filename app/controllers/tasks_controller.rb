class TasksController < ApplicationController
    before_action :require_user_logged_in
    
    def index
        @task = Task.all
    end
    
    def show
        set_task
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)

        if @task.save
            flash[:success] = 'Task が正常に作成されました'
            redirect_to @task
        else
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
            flash.now[:danger] = 'Task が作成されませんでした'
            render :new
        end
    end
    
    def edit
        set_task
    end

    def update
        set_task
        if @task.update(task_params)
            flash[:success] = 'Task が更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Task は更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        set_task
        @task.destroy
        
        flash[:success] = 'Task は削除されました'
        redirect_to tasks_url
    end
    
    private
    
    def set_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:user_id, :content, :status)
    end
end