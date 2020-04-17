class EmailExchangerMailerPreview < ActionMailer::Preview

    def send_realtor_profile
      @realtor = User.realtors.first
      @order = Order.first
      EmailExchangerMailer.send_realtor_profile(@realtor, @order)
    end

    def send_client_orders
      realtor = User.realtors.first
      current_user = User.clients.first
      orders = current_user.orders
      email = realtor.email
      EmailExchangerMailer.send_client_orders(orders, email, current_user)
    end
  
  end