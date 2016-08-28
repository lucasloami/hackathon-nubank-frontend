class Admin::MissionsController < ApplicationController
    before_action :set_mission, only: [:show, :update, :destroy]

    def index
        render json: Mission.all, include: [ :tasks, :messages ], status: 200
    end

    def show
        if params[:id]
            if @mission
                render json: @mission, include: [ :tasks, :messages ], status: 200
            else
                render json: { errors: [ "Mission não existe" ] }, status: 400
            end
        end
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
        @mission.destroy
        render json: { message: "Mission deletada" }, status: 200
    end

    def create
        if params[:mission] 
            @mission = Mission.new(mission_params)
            if @mission.save
                create_tasks(@mission, params[:mission][:duration_month])
            
                render json: @mission, include: [ :tasks, :messages ], status: 200
            else
                render json: @mission.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def mission_params
        params.require(:mission).permit(:id, :name, :description, :goal, :start_date, :end_date, :value, :user_id)
    end

    def set_mission
      @mission = Mission.find(params[:id])
    end

     def create_tasks( mission, months )
        limit = months.to_i + 1

        puts "create #{months} #{limit} #{(mission.value.to_f / months.to_i).round(2)} #{mission.value.to_f} #{mission.id}"
        value_divide = mission.value.to_f / limit

        for counter in 1..limit
            end_date = DateTime.now + counter.month
            start_date = end_date - 1.month

            mission.tasks.new({
                        category: "mission", 
                        description: mission.name, 
                        accepted: true, 
                        value: value_divide.round(2),
                        xp: 10 * counter,
                        start_date: start_date,
                        end_date: end_date,
                        completed: false
                    })
            mission.save
        end
    end
end
