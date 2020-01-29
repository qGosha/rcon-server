module Api::V1
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

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

      def create_user_params
        main_attr = [ :email, :password, :role ]
        params.permit(main_attr << spicific_role_params(params[:role]))
      end

      def update_user_params
        main_attr = [ :email, :password ]
        params.permit(main_attr << spicific_role_params(@user.role))
      end

      def spicific_role_params(role)
        client_attr = { client_attributes: [:first_name, :id] }
        realtor_attr = { realtor_attributes: [:first_name, :last_name, :id] }
        if role == 'realtor'
          realtor_attr
        elsif role == 'client'
          client_attr
        end
      end
  end
end
