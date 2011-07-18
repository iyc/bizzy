
module Test
  class Parent
    def self.inherited(subclass)
      puts self
    end
  end
end

class Child < Test::Parent
end


=begin
require './sql/sql'
require 'sequel'

DB = Sequel.sqlite

# create an items table
DB.create_table :items do
  primary_key :id
  String :name
  Float :price
end

puts DB[:items].count


sqlo = sql {
  from( sql{
    from('plnact','pa')
    select('pa.plncomboid')
  }, 'a')
  
  join( sql{
    from('plncombo','pc')
    select('pc.plncomboid')
  }, 'c').on('c.plncomboid = a.plncomboid')
  
  select('c.plncomboid')
  
  where('c.plncomboid').in( sql{
    from('plncombo')
    select('plncomboid')
  })
  
  where('c.statid = 1')

}
puts sqlo.to_sql

  select('v.varietytag1')
  select('k.kindid', 'kindid')
  select('k.kind', 'kind')
  select('sum(pa.vol)').as('totalvol')
  select('sum(case when cp.calyearid = 7 then pa.vol else 0 end)').as('vol_7')
  select('sum(case when cp.calyearid = 8 then pa.vol else 0 end)').as('vol_8')
  select('sum(case when cp.calyearid = 9 then pa.vol else 0 end)').as('vol_9')
  select('sum(case when cp.calyearid = 10 then pa.vol else 0 end)').as('vol_10')

  begin_or
    where('cp.calyearid >= 7')
    where('cp.calyearid <= 10')
    
    begin_and
      where('p.prodid>=100')
      where('p.prodid<=200')
    end_and  
  end_or
  
  where('pc.statid=1')


=begin
  from('plnact', 'pa')
  join('calperiod', 'cp').on('cp.calperiodid = pa.calperiodid')
  join('plncombo', 'pc').on('pc.plncomboid = pa.plncomboid')
  join('prods', 'p').on('p.prodid = pc.prodid')
  join('kinds', 'k').on('k.kindid = p.kindid')
  join('varietys').as('v').on('v.varietyid = p.varietyid')

  select('v.varietytag1')
  select('k.kindid', 'kindid')
  select('k.kind', 'kind')
  select('sum(pa.vol)').as('totalvol')
  select('sum(case when cp.calyearid = 7 then pa.vol else 0 end)').as('vol_7')
  select('sum(case when cp.calyearid = 8 then pa.vol else 0 end)').as('vol_8')
  select('sum(case when cp.calyearid = 9 then pa.vol else 0 end)').as('vol_9')
  select('sum(case when cp.calyearid = 10 then pa.vol else 0 end)').as('vol_10')

  where('cp.calyearid >= 7')
  where('cp.calperiodid <= 10')
  
  begin_or()
      where('pa.vol > 0')
      where('pa.price0 > 0')
  end_or()
    
  group('v.varietytag1')
  group('k.kindid')
  group('k.kind')

  order('totalvol')
=end



