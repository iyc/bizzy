require 'sequel'
load "sql.rb"

DB = Sequel.connect(:adapter=>'oracle', 
                    :host=>'arete3.areteinc.com', 
                    :database=>'arete3', 
                    :user=>'trp_gap', 
                    :password=>'arete01')

puts DB[:whses].count
