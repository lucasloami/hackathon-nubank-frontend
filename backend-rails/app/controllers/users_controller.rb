class UsersController < ApplicationController
    before_action :set_user, only: [:create, :show, :update, :destroy]

    def index
        render json: User.all, methods: [:total_xp, :has_mission], include: [:skills, missions: { include: [:tasks] } ] , status: 200
    end

    def logged_user
        if current_user
            render json: current_user, status: 200
        else
            render json: {
                data: {
                    errors: ["Usuário não logado"],                }
            }, status: 400
        end
    end

    def skills
        if params 
            @user = User.find(params[:user_id])
            render json: {
                data: {
                    skills: @user.skills
                }
            }, status: 200
        end
    end

    def show
        if @user
            render json: @user, include: [:skills, missions: { include: [:tasks] } ], methods: [:total_xp, :has_mission] , status: 200
        end
    end

    private

    def set_user
      @user = User.includes(:skills).find(params[:id])
    end

end
