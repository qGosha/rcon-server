object false

child @realtors, :object_root => false, :root => "items" do 
    extends("realtors/show")
end
node(:total) { @total }
node(:rated_by_me) { @rated_by_me }
node(:responded_or_sent_orders) { @responded_or_sent_orders }