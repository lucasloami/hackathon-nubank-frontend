class SkillsController < ApplicationController
    before_action :set_user, only: [:index, :create, :show, :update, :destroy]

    def index
        if params[:user_id]
            if @user
                render json: @user, include: [:skills] , status: 200
            else
                render json: { errors: [ "Usuario não existe" ] }, status: 400
            end
        end
    end

    def show
  
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
        @user.skills.each { |skill|
            if( skill.id == params[:id].to_i ) 
                skill.destroy
                break
            end
        }
        render json: { message: "Skill deletada" }, status: 200
    end

    def create
        if params[:user_id] && params[:skill]
            @skill = Skill.find(params[:skill][:id])
            @user.skills << @skill
            if @user.save
                render json: @user, include: [:skills], status: 200
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        end
    rescue Exception => e 
        render json: { errors: [ e.message ] }, status: 400
    end

    private

    def skill_params
        params.require(:skill).permit(:id, :name, :description)
    end

    def set_user
      @user = User.includes(:skills).find(params[:user_id])
    end
end
