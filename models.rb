#- models for test.rb

# -----------------------------------------------------------
class Item < Sequel::Model
  
  #one_to_many :line_items, :key => [:item_id], :primary_key => [:item_id]
  
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :items do
      
      Integer :item_id
      primary_key [:item_id], :serial, :auto_increment => true

      String :item_name
      Float :price0
      Float :price1
    end
  end

end

# -----------------------------------------------------------
class Line < Sequel::Model
  
  one_to_many :line_items, :key => [:line_id], :primary_key => [:line_id]
  
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :lines do
      Integer :line_id
      primary_key [:line_id], :serial, :auto_increment => true

    end
  end

end

# -----------------------------------------------------------
class LineItem < Sequel::Model

  #one_to_many :line_item_bkts, :key=>[:line_id, :item_id], :primary_key => [:line_id, :item_id]
  one_to_one :line, :key => [:line_id], :primary_key => [:line_id]
  #one_to_one :item, :key => [:item_id], :primary_key => [:item_id]
   
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :line_items do
      Integer :line_id
      Integer :item_id
      primary_key [:line_id, :item_id]

      Integer :cost
    end
  end
end
