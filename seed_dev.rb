
#- structures for test.rb

# Item -- (Integer :item_id*, String :item_name, Float :price0, Float :price1)
# Line -- (Integer :line_id*, Integer :whse_id, String :line_name)
# LineItem -- (Integer :line_id*, Integer :item_id*, Integer :whse_id)
# Bkt -- (Integer :line_id*, Integer :item_id*, Integer :whse_id)
# LineItemBkt -- (Integer :line_id*, Integer :item_id*, Integer :bkt_id, Integer :whse_id)
# Whse -- (Integer :whse_id*, String :address) 

# puts RUBY_VERSION ## 1.8.7 through mate, 1.9.2 through terminal
# return

whse = Whse.create!(:address => "south street")

Item.create!(:item_name => "Item One", :price0 => 0.99, :price1 => 1.99)
Item.create!(:item_name => "Item Two", :price0 => 0.59, :price1 => 1.59)
Item.create!(:item_name => "Item Three", :price0 => 0.49, :price1 => 1.49)
Item.create!(:item_name => "Item Four", :price0 => 0.89, :price1 => 1.89)
Item.create!(:item_name => "Item Five", :price0 => 0.59, :price1 => 1.59)
Item.create!(:item_name => "Item Six", :price0 => 0.29, :price1 => 1.29)
Item.create!(:item_name => "Item Seven", :price0 => 0.79, :price1 => 1.79)

#Line.create!(:line_id*, Integer :whse_id, String :line_name)
# LineItem -- (Integer :line_id*, Integer :item_id*, Integer :whse_id)
# Bkt -- (Integer :line_id*, Integer :item_id*, Integer :whse_id)
# LineItemBkt -- (Integer :line_id*, Integer :item_id*, Integer :bkt_id, Integer :whse_id)
# Whse -- (Integer :whse_id*, String :address) 
