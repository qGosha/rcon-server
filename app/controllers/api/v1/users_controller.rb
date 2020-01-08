module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

    # GET /users
    def index
      @users = User.all

      render :json => @users
    end

    # GET /users/1
    def show
      respond_with_current_user(@user)
    end

    # POST /users
    def create
      @user = User.new(create_user_params)
      if @user.save
        log_in @user
        respond_with_current_user(@user)
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user.update(update_user_params)
        respond_with_current_user(@user)
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
      if @user.destroy
        render :json => nil, :status => :ok
      else
        render :json => @user.errors.full_messages, :status => :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def create_user_params
        main_attr = [ :email, :password, :role ]
        client_attr = { client_attributes: [:first_name] }
        realtor_attr = { realtor_attributes: [:first_name, :last_name] }
        if params[:role] == 'realtor'
          main_attr << realtor_attr
        elsif params[:role] == 'client'
          main_attr << client_attr
        end
        params.permit(main_attr)
      end

      def update_user_params
        params.permit(:email, :password)
      end
  end
end
