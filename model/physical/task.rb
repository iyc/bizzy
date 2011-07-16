# -----------------------------------------------------------
class Task < Sequel::Model
  
  associate :one_to_many, :links, :primary_key => [:taskid], :key => [:parentid]  
  associate :one_to_many, :links, :primary_key => [:taskid], :key => [:childid]   

  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :tasks do      
      Integer :taskid
      primary_key [:taskid], :serial, :auto_increment => true

      Integer :ownwhoid
      Integer :stepownid
      Integer :woid
      Integer :stepid
      Integer :appid
      Integer :reqwhoid
      Integer :orgtaskid
      Integer :whoid
      
      String :name
      String :note
    end
  end

end
