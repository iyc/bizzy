require "sequel"

# --------------------------
class Step < Sequel::Model
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :steps do
      Integer :stepid
      primary_key [:stepid], :serial, :auto_increment => true
      String :step
      String :name
      String :seq
      Integer :itemid
    end#do
  end#def
end#class