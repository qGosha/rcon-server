module Api::V1
    class RealtorProfilesController < ApplicationController
        before_action :logged_in_user
        before_action :is_realtor

        def send_realtor_profile
            order = Order.find_by(id: send_params[:order_id])
            user = current_user
            if RespondedOrSentOrder.create({order_id: order.id, realtor_id: user.id})
                EmailExchangerMailer.send_realtor_profile(user, order).deliver_now

                render :json => { order_id: order.id }, :status => :ok
            end
        end

        def create
            hash_params = realtor_profile_params.to_h
            email = { email: hash_params[:email] || current_user.email}
            @realtor_profile = current_user.build_realtor_profile(hash_params.merge(email))
            if @realtor_profile.save
                upload_avatar if avatar_params[:avatar]
                render 'realtor_profiles/show'
            else
                render :json => @realtor_profile.errors.full_messages, :status => :unprocessable_entity
            end
        end

        def update
            @realtor_profile = current_user.realtor_profile
            if @realtor_profile.update(realtor_profile_params)
                upload_avatar if avatar_params[:avatar]
                render 'realtor_profiles/show'
            else
                render :json => @realtor_profile.errors.full_messages, :status => :unprocessable_entity
            end
        end

    private

        def realtor_profile_params
            params[:address_attributes] = JSON.parse(params["address_attributes"])
            params.permit(:id, :tel, :bio, :email, :order_type, address_attributes: [:id, :city, :state, :zip, :street])
        end

        def address_attributes
            JSON.parse(params["address_attributes"])
        end

        def avatar_params
            params.permit(:avatar)
        end

        def upload_avatar
            current_user.realtor_profile.avatar.attach(avatar_params[:avatar])
        end

        def send_params
            params.permit(:order_id)
        end
    end
end
