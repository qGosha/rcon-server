module Api::V1
    class OrdersController < ApplicationController
        before_action :logged_in_user
        before_action :is_client, only: [:create, :destroy, :update]

        def create
            email = { email: order_params[:email] || current_user.email}
            @order = current_user.client.orders.build(order_params.merge(email))
            if @order.save
                render :json => @order.as_json(include: { address: { except: [:created_at, :updated_at] } }, except: :updated_at), :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        private

        def order_params
            params.permit(:tel, :description, :email, :order_type, address_attributes: [:id, :city, :state, :zip, :street])
        end
    end
end
