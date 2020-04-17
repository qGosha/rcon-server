module Api::V1
    class RealtorsController < ApplicationController
        before_action :logged_in_user
        before_action :is_client, only: [:index]
        
        def index
            if search_params[:state].present?
                state_realtors = User.realtors.joins(:address).where(:addresses => { state: search_params[:state] })
                @realtors = state_realtors.paginate(page: search_params[:page], per_page: search_params[:per_page])
                @total = state_realtors.size
            else
                @realtors = User.realtors.paginate(page: search_params[:page], per_page: search_params[:per_page])
                @total = User.realtors.size
            end
            @rated_by_me = current_user.given_rating.map(&:realtor_id) & @realtors.map(&:id)
            render "realtors/index"
        end

    private

        def search_params
            params.permit(:page, :per_page, :state)
        end
    end
end