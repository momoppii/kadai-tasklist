class TasksController < ApplicationController
    def index
        @task = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = 'Task が正常に作成されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Task が作成されませんでした'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
        
        if @task.edit
            flash[:success] = 'Task が編集されました'
        else
            flash.new[:danger] = 'Task を編集できませんでした'
            render :new
        end
    end

    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'Task が更新されました'
            redirect_to @task
        else
            flash.now[:danger] = 'Task は更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = 'Task は削除されました'
        redirect_to tasks_url
    end
    
    def task_params
        params.require(:task).permit(:content)
    end
end