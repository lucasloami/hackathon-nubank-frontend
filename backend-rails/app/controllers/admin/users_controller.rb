class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

    def index
        render json: User.all, include: [:skills, :missions], methods: [:total_xp, :has_mission], status: 200
    end

    def show
        if params[:id]
            if @user
                render json: @user, include: [:skills, :missions], methods: [:total_xp, :has_mission], status: 200
            else
                render json: { errors: [ "User não existe" ] }, status: 400
            end
        end
    end

    def update
        if params[:id] 
            if params[:user][:skill_id]
                @skill = Skill.find(params[:user][:skill_id])
                @user.skills << @skill
            end 
            if @user.update(user_params)
                render json: @user, include: [:skills, :missions], methods: [:total_xp, :has_mission], status: 200
            else
                render json: @user.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @user.destroy
        render json: { user: "User deletada" }, status: 200
    end

    def create
        if params[:user] 
            @user = User.new(user_params)
            if @user.save
                render json: @user, methods: [:total_xp, :has_mission], status: 200
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:id, :name, :nickname, :image, :email, :mentor_id, :role_id)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
