module Api::V1
    class RealtorsController < ApplicationController
        before_action :logged_in_user
        before_action :is_client, only: [:index, :search]
        
        def index
            Realtors.paginate(page: params[:page], per_page: params[:per_page])
        end

        def search

        end
    end
end