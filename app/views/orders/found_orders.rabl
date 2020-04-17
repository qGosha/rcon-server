object false

child @orders, :object_root => false, :root => "items" do 
    extends("orders/show")
end
node(:total) { @total }
node(:responded_to) { @responded_to }