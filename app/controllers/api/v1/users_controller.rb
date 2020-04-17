module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

    # GET /users/1
    # def show
    #   render 'users/show'
    # end

    # POST /users
    def create
      @user = User.new(create_user_params)
      if @user.save
        log_in @user
        render 'users/show'
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(update_user_params)
        render 'users/show'
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      if @user.destroy
        log_out if logged_in?
        render :json => true, :status => :ok
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      def create_user_params
        params.permit(:email, :password, :password_confirmation, :role, :first_name, :last_name)
      end

      def update_user_params
        params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
      end
  end
end
