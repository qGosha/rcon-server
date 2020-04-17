module Api::V1
    class RealtorRatingsController < ApplicationController
        before_action :is_client, only: [:create, :update]
        before_action :set_realtor, only: [:create, :update, :destroy]
        before_action :find_rating, only: [:update, :destroy]

        def create
            if @realtor.received_rating.create(realtor_id: rating_params[:id], value: rating_params[:rating], client_id: current_user.id)
                render 'realtors/show'
            else
                render :json => false, :status => :unprocessable_entity
            end
        end

        def update
            if @rating.update(value: rating_params[:rating])
                render 'realtors/show'
            else
                render :json => false, :status => :unprocessable_entity
            end
        end

        def destroy
            if @rating.destroy
                render :json => true, :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        private

        def rating_params
            params.permit(:id, :rating)
        end

        def set_realtor
            @realtor = User.find_by(id: rating_params[:id])
        end

        def find_rating
            @rating = @realtor.received_rating.find_by(realtor_id: rating_params[:id], client_id: current_user.id)
        end
    end
end



# def update_rating
#     @realtor = User.find_by(id: params[:id])
#     if realtor.update(params.permit(:rating))
#         render 'realtors/show'
#     else
#         render :json => @realtor.errors.full_messages, :status => :unprocessable_entity
#     end
# end