class InsertSeedData1 < ActiveRecord::Migration
  def up
    ro = Chaina.create(name: 'Rooms')
    #ba = Chaina.create(name: 'Baths')
    #la = Chaina.create(name: 'Land area')
    #ba = Chaina.create(name: 'Built-up area')
    #pr = Chaina.create(name: 'Price')

    ro1 = Chainb.create(name: '1', chaina: ro) 
    ro2 = Chainb.create(name: '2', chaina: ro)
    ro3 = Chainb.create(name: '3', chaina: ro) 
    ro4 = Chainb.create(name: '4', chaina: ro)    
    ro5 = Chainb.create(name: '5', chaina: ro) 
    ro6 = Chainb.create(name: '6', chaina: ro)    
    ro7 = Chainb.create(name: '7', chaina: ro) 
    ro8 = Chainb.create(name: '8', chaina: ro)    
    ro9 = Chainb.create(name: '9', chaina: ro) 
    ro10 = Chainb.create(name: '10', chaina: ro)

    Chainc.create(name: '1', chainb: ro1)
    Chainc.create(name: '2', chainb: ro1)
    Chainc.create(name: '3', chainb: ro1)
    Chainc.create(name: '4', chainb: ro1)
    Chainc.create(name: '5', chainb: ro1)
    Chainc.create(name: '6', chainb: ro1)
    Chainc.create(name: '7', chainb: ro1)
    Chainc.create(name: '8', chainb: ro1)
    Chainc.create(name: '9', chainb: ro1)
    Chainc.create(name: '10', chainb: ro1)

    Chainc.create(name: '2', chainb: ro2)
    Chainc.create(name: '3', chainb: ro2)
    Chainc.create(name: '4', chainb: ro2)
    Chainc.create(name: '5', chainb: ro2)
    Chainc.create(name: '6', chainb: ro2)
    Chainc.create(name: '7', chainb: ro2)
    Chainc.create(name: '8', chainb: ro2)
    Chainc.create(name: '9', chainb: ro2)
    Chainc.create(name: '10', chainb: ro2)

    Chainc.create(name: '3', chainb: ro3)
    Chainc.create(name: '4', chainb: ro3)
    Chainc.create(name: '5', chainb: ro3)
    Chainc.create(name: '6', chainb: ro3)
    Chainc.create(name: '7', chainb: ro3)
    Chainc.create(name: '8', chainb: ro3)
    Chainc.create(name: '9', chainb: ro3)
    Chainc.create(name: '10', chainb: ro3)

    Chainc.create(name: '4', chainb: ro4)
    Chainc.create(name: '5', chainb: ro4)
    Chainc.create(name: '6', chainb: ro4)
    Chainc.create(name: '7', chainb: ro4)
    Chainc.create(name: '8', chainb: ro4)
    Chainc.create(name: '9', chainb: ro4)
    Chainc.create(name: '10', chainb: ro4)

    Chainc.create(name: '5', chainb: ro5)
    Chainc.create(name: '6', chainb: ro5)
    Chainc.create(name: '7', chainb: ro5)
    Chainc.create(name: '8', chainb: ro5)
    Chainc.create(name: '9', chainb: ro5)
    Chainc.create(name: '10', chainb: ro5)

    Chainc.create(name: '6', chainb: ro6)
    Chainc.create(name: '7', chainb: ro6)
    Chainc.create(name: '8', chainb: ro6)
    Chainc.create(name: '9', chainb: ro6)
    Chainc.create(name: '10', chainb: ro6)

    Chainc.create(name: '7', chainb: ro7)
    Chainc.create(name: '8', chainb: ro7)
    Chainc.create(name: '9', chainb: ro7)
    Chainc.create(name: '10', chainb: ro7)

    Chainc.create(name: '8', chainb: ro8)
    Chainc.create(name: '9', chainb: ro8)
    Chainc.create(name: '10', chainb: ro8)

    Chainc.create(name: '9', chainb: ro9)
    Chainc.create(name: '10', chainb: ro9)

    Chainc.create(name: '10', chainb: ro10)
    
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chaina.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainb.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainc.table_name}")
  end
end