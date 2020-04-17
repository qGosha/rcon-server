module Api::V1
    class OrdersController < ApplicationController
        before_action :logged_in_user
        before_action :is_client, only: [:create, :destroy, :update, :my_orders]
        before_action :is_realtor, only: [:index]
        before_action :has_realtor_profile, only: [:index]

        def index
            if search_params_present?
                search_hash = {}

                address_search_hash = {}
                address_search_hash[:state] = search_params[:state] if search_params[:state].present?
                address_search_hash[:zip] = search_params[:zip] if search_params[:zip].present?

                search_hash[:addresses] = address_search_hash if address_search_hash.keys.size > 0
                search_hash[:order_type] = search_params[:order_type] if search_params[:order_type].present?

                search_result = Order.joins(:address).where(search_hash)

                @orders = search_result.paginate(page: pagination_params[:page], per_page: pagination_params[:per_page])
                @total = search_result.size
                @responded_to = responded_to_orders(search_result)
            else
                @orders = Order.paginate(page: pagination_params[:page], per_page: pagination_params[:per_page])
                @total = Order.count
                @responded_to = responded_to_orders(@orders)
            end
            render "orders/found_orders"
        end

        def my_orders
            @orders = current_user.orders
            render "orders/index"
        end

        def responded_by_me_orders
            responded_order_ids = RealtorRespondedOrder.where(realtor_id: current_user.id)
            @orders = Order.where(id: responded_order_ids)
            render "orders/index"
        end

        def create
            email = { email: order_params[:email] || current_user.email}
            @order = current_user.orders.build(order_params.merge(email))
            @address = @order.address
            if @order.save
                render "orders/show"
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        def destroy
            @order = current_user.orders.find_by(id: params[:id])
            if @order.destroy
                render :json => true, :status => :ok
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        def update
            @order = current_user.orders.find_by(id: params[:id])
            if @order.update(order_params)
                render "orders/show"
            else
                render :json => @order.errors.full_messages, :status => :unprocessable_entity
            end
        end

        private

        def order_params
            params.permit(:id, :tel, :description, :email, :order_type, address_attributes: [:id, :city, :state, :zip, :street])
        end

        def pagination_params
            params.permit(:page, :per_page)
        end

        def search_params
            params.permit(:order_type, :state, :zip)
        end

        def search_params_present?
            search_params.keys.size > 0
        end

        def responded_to_orders (orders)
            RealtorRespondedOrder.where(realtor_id: current_user.id, order_id: orders.map(&:id)).map(&:order_id)
        end
    end
end
