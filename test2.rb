require 'rubygems'
require 'sequel'

db = Sequel.sqlite('test.db') # sqlite db on disk

# -----------------------------------------------------------
class Item < Sequel::Model
  def initialize(db)
    super(db)
  end
end

puts db[:items].count
puts Item.count




