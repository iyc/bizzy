# --------------------------
class Who < Sequel::Model
  
  #one_to_many :links, :key => [:item_id], :primary_key => [:item_id]  
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :whos do      
      Integer :whoid
      primary_key [:whoid], :serial, :auto_increment => true
      Integer :orgid
      String :who
      String :name
      String :email
      String :whostatid
      String :firstname
      String :lastname
    end#do
  end#def
end#class
