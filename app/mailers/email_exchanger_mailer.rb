class EmailExchangerMailer < ApplicationMailer
    
    def send_realtor_profile(realtor, order)
        @realtor = realtor
        @profile = realtor.realtor_profile
        mail to: order.email, subject: "#{@realtor.first_name} #{@realtor.last_name} just responded to your order"
    end

    def send_client_orders(orders, email, realtor)
        @orders = orders
        @realtor = realtor
        mail to: email, subject: "Someone is interested in working with you"
    end
end
