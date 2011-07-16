
# ----------
module Seed

  # --------------------
  class Client
  
    # ------------------------------
    def self.create_table!(sequel_db)
      sequel_db.create_table! :clients do
        Integer :clientid
        primary_key [:clientid], :serial, :auto_increment => true
      
        Integer :orgid
        Integer :siteid
        Integer :clientstatid
        Integer :lastname
        Integer :jobtitle
        Integer :countryid

        String :client
        String :firstname
        String :street1
        String :street2
        String :city
        String :state
        String :zipcode
        String :busphone1
        String :busphone2
        String :homephone
        String :cellphone      
        String :email1
        String :email2
        String :notes
      
      end#do
    end#def

    # -----------------------------------------------------------
    def self.seed
      Client.insert(:client => "south american client")
      Client.insert(:client => "north american client")
      Client.insert(:client => "canadian clientstatid")
    end
  
  end#class
end#module