module Api::V1
  class SessionsController < ApplicationController
      def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
          log_in @user
          # if @user.activated
          params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
          render 'users/show'
          # else
          #   message  = "Account not activated. "
          #   message += "Check your email for the activation link."
          #   flash[:warning] = message
          #   redirect_to root_url
          # end
        else 
          render :json => nil, :status => :unauthorized
          # flash.now[:danger] = 'Invalid email/password combination'
          # render 'new'
        end
      end

      def is_logged_in?
        if logged_in?
          @user = current_user
          render 'users/show'
        else
          render :json => false, :status => :unauthorized 
        end
      end
    
      def destroy
        log_out if logged_in?
        render :json => nil, :status => 200
      end
  end
end
