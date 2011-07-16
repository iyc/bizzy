# --------------------------
class Link < Sequel::Model

  #one_to_many :key => [:line_id], :primary_key => [:line_id]  

  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :links do
      Integer :parentid
      Integer :childid
      Integer :seq
      primary_key [:parentid, :childid, :seq], :serial, :auto_increment => true
    end
  end
end
