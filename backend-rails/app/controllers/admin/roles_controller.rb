class Admin::RolesController < ApplicationController
    before_action :set_role, only: [:show, :update, :destroy]

    def index
        render json: Role.all, status: 200
    end

    def show
        if params[:id]
            if @role
                render json: @role, status: 200
            else
                render json: { errors: [ "Role não existe" ] }, status: 400
            end
        end
    end

    def update
        if params[:id] 
            if @role.update(role_params)
                render json: @role, status: 200
            else
                render json: @role.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @role.destroy
        render json: { message: "Role deletada" }, status: 200
    end

    def create
        if params[:role] 
            @role = Role.new(role_params)
            if @role.save
                render json: @role, status: 200
            else
                render json: @role.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def role_params
        params.require(:role).permit(:name)
    end

    def set_role
      @role = Role.find(params[:id])
    end
end
