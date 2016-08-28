class Admin::SkillsController < ApplicationController
    before_action :set_skill, only: [:show, :update, :destroy]

    def index
        render json: Skill.all, status: 200
    end

    def show
        if params[:id]
            if @skill
                render json: @skill, status: 200
            else
                render json: { errors: [ "Skill não existe" ] }, status: 400
            end
        end
    end

    def update
        if params[:id] 
            if @skill.update(skill_params)
                render json: @skill, status: 200
            else
                render json: @skill.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @skill.destroy
        render json: { message: "Skill deletada" }, status: 200
    end

    def create
        if params[:skill] 
            @skill = Skill.new(skill_params)
            if @skill.save
                render json: @skill, status: 200
            else
                render json: @skill.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def skill_params
        params.require(:skill).permit(:id, :name, :description, :image_url)
    end

    def set_skill
      @skill = Skill.find(params[:id])
    end
end
