module Api::V1
    class OrdersController < ApplicationController
        before_action :logged_in_user
        before_action :is_client, only: [:create, :destroy, :update, :my_orders]

        def my_orders
           render :json => current_user.client.orders.as_json(json_order_response), :status => :ok
        end

        def create
            email = { email: order_params[:email] || current_user.email}
            @order = current_user.client.orders.build(order_params.merge(email))
            if @order.save
                render :json => @order.as_json(json_order_response), :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        def destroy
            @order = Order.find(params[:id])
            if @order.destroy
                render :json => true, :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        def update
            @order = Order.find(params[:id])
            if @order.update(order_params)
                render :json => @order.as_json(json_order_response), :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        private

        def order_params
            params.permit(:id, :tel, :description, :email, :order_type, address_attributes: [:id, :city, :state, :zip, :street])
        end

        def json_order_response
            { include: { address: { except: [:created_at, :updated_at] } }, except: :updated_at }
        end
    end
end
