object @order

attributes :id, :tel, :description, :email, :order_type

child(:address) { extends("addresses/show") }
