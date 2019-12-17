module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

    # GET /users
    def index
      @users = User.all

      render json: @users
    end

    # GET /users/1
    def show
      render json: @user
    end

    # POST /users
    def create
      @user = User.new(create_user_params)

      if @user.save
        render :show
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(update_user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      if @user.destroy
        render :json => nil, :status => 200
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def create_user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :is_client, :is_realtor)
      end

      def update_user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      end
  end
end
