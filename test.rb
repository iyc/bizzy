#- todos:
#[+] #01: hook line-products to line-product-bkts with a composite key
#[+] #02: navigate lp.lpbs.first.lp.lpbs.first.lb.... and see if they are equal
#[+] #03: flip to jquo project in ~/Dev/rb/rquo OR try ~/Dev/rb/koans/*

#require 'ruby-debug'
require 'rubygems'
require 'sequel'
require 'logger'

db = Sequel.sqlite('test.db', :loggers => [Logger.new(STDOUT)]) 

load 'models.rb'  # gets the datastructures

#- load records
loading = false
if loading
  beginning = Time.now
  Line.delete
  LineItem.delete
  (1..1).each { |line_num|
    line_id = Line.insert()
    (1..100000).each { |line_item_num|
      LineItem.insert(:line_id=>line_id, :item_id => line_item_num)
    }
  }
  puts "Inserting records took #{Time.now-beginning}"
end

#- calculate
beginning = Time.now
line_items = Line.find(:line_id => 1).line_items
total = 0
count = 0

#line_items.each {|line_item|
#  total += line_item.item_id
#  count += 1
#}

(1..100000).each { |item_id| 
  line_item = LineItem.find(:item_id => item_id)
  total += line_item.item_id
  count += 1
}

puts "Average is "+(total/count).to_s
puts "Time elapsed #{Time.now - beginning} seconds"
puts line_items.count