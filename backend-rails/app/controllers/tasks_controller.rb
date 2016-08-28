class TasksController < ApplicationController
    before_action :set_user, only: [:index, :create, :show, :update, :destroy]
    before_action :set_mission, only: [:index, :create, :show, :update, :destroy]

    def index
        if params[:user_id]
            @task = Task.where(mission_id: params[:mission_id])
            if @task
                render json: @task , status: 200
            else
                render json: { errors: [ "Usuario não existe" ] }, status: 400
            end
        end
    end

    def show
  
    end

    def update
        if params[:id] 
            if @mission.update(mission_params)
                render json: @mission, status: 200
            else
                render json: @mission.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @user.missions.each { |mission|
            if( mission.id == params[:id].to_i ) 
                mission.destroy
                break
            end
        }
        render json: { message: "Missão deletada" }, status: 200
    end

    def create
        if params[:user_id] && params[:mission]
            @mission = Skill.find(params[:mission][:id])
            @user.missions << @mission
            if @user.save
                render json: @user, include: [:missions], status: 200
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        end
    rescue Exception => e 
        render json: { errors: [ e.message ] }, status: 400
    end

    private

    def mission_params
        params.require(:mission).permit(:id, :name, :description)
    end

    def set_user
      @user = User.includes(:missions).find(params[:user_id])
    end

    def set_mission
      @mission = Mission.includes(:tasks).find(params[:mission_id])
    end
end
