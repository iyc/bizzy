#- models for physical

# TODO
# [-] link relationship tables
# [-] seed data

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

# --------------------------
class Client < Sequel::Model
  # -----------------------------------------------------------
  def self.create_table!(db)
    db.create_table! :clients do
      Integer :clientid
      primary_key [:clientid], :serial, :auto_increment => true
      
      Integer :orgid, :siteid, :clientstatid
      String :client, :firstname, :lastname, :jobtitle
      String :street1, :street2, :city, :state, :zipcode, :busphone1, :busphone2, :homephone, :cellphone
      Integer :countryid
      
      String :email1, :email2, :notes
      
    end#do
  end#def
  
end#class

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