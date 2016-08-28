class Admin::TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy]

    def index
        render json: Task.all, status: 200
    end

    def show
        if params[:id]
            if @task
                render json: @task, status: 200
            else
                render json: { errors: [ "Task não existe" ] }, status: 400
            end
        end
    end

    def update
        if params[:id] 
            if @task.update(task_params)
                render json: @task, status: 200
            else
                render json: @task.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @task.destroy
        render json: { message: "Task deletada" }, status: 200
    end

    def create
        if params[:task] 
            @task = Task.new(task_params)
            if @task.save
                render json: @task, status: 200
            else
                render json: @task.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def task_params
        params.require(:task).permit(:id, :title, :description, :goal, :start_date, :end_date, :value, :xp, :mission_id, :prize, :completed)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
