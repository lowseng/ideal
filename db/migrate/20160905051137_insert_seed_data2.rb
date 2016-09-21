class InsertSeedData2 < ActiveRecord::Migration
  def up
    ro = Chaina.create(name: 'Price')

    ro1 = Chainb.create(name:   '100000', chaina: ro) 
    ro2 = Chainb.create(name:   '200000', chaina: ro)
    ro3 = Chainb.create(name:   '300000', chaina: ro) 
    ro4 = Chainb.create(name:   '400000', chaina: ro)    
    ro5 = Chainb.create(name:   '500000', chaina: ro) 
    ro6 = Chainb.create(name:   '750000', chaina: ro)    
    ro7 = Chainb.create(name:  '1000000', chaina: ro) 
    ro8 = Chainb.create(name:  '1500000', chaina: ro)    
    ro9 = Chainb.create(name:  '2000000', chaina: ro) 
    ro10 = Chainb.create(name: '2500000', chaina: ro)

    Chainc.create(name:  '100000', chainb: ro1)
    Chainc.create(name:  '200000', chainb: ro1)
    Chainc.create(name:  '300000', chainb: ro1)
    Chainc.create(name:  '400000', chainb: ro1)
    Chainc.create(name:  '500000', chainb: ro1)
    Chainc.create(name:  '750000', chainb: ro1)
    Chainc.create(name: '1000000', chainb: ro1)
    Chainc.create(name: '1500000', chainb: ro1)
    Chainc.create(name: '2000000', chainb: ro1)
    Chainc.create(name: '2500000', chainb: ro1)

    Chainc.create(name:  '200000', chainb: ro2)
    Chainc.create(name:  '300000', chainb: ro2)
    Chainc.create(name:  '400000', chainb: ro2)
    Chainc.create(name:  '500000', chainb: ro2)
    Chainc.create(name:  '750000', chainb: ro2)
    Chainc.create(name: '1000000', chainb: ro2)
    Chainc.create(name: '1500000', chainb: ro2)
    Chainc.create(name: '2000000', chainb: ro2)
    Chainc.create(name: '2500000', chainb: ro2)

    Chainc.create(name:  '300000', chainb: ro3)
    Chainc.create(name:  '400000', chainb: ro3)
    Chainc.create(name:  '500000', chainb: ro3)
    Chainc.create(name:  '750000', chainb: ro3)
    Chainc.create(name: '1000000', chainb: ro3)
    Chainc.create(name: '1500000', chainb: ro3)
    Chainc.create(name: '2000000', chainb: ro3)
    Chainc.create(name: '2500000', chainb: ro3)

    Chainc.create(name:  '400000', chainb: ro4)
    Chainc.create(name:  '500000', chainb: ro4)
    Chainc.create(name:  '750000', chainb: ro4)
    Chainc.create(name: '1000000', chainb: ro4)
    Chainc.create(name: '1500000', chainb: ro4)
    Chainc.create(name: '2000000', chainb: ro4)
    Chainc.create(name: '2500000', chainb: ro4)

    Chainc.create(name:  '500000', chainb: ro5)
    Chainc.create(name:  '750000', chainb: ro5)
    Chainc.create(name: '1000000', chainb: ro5)
    Chainc.create(name: '1500000', chainb: ro5)
    Chainc.create(name: '2000000', chainb: ro5)
    Chainc.create(name: '2500000', chainb: ro5)

    Chainc.create(name:  '750000', chainb: ro6)
    Chainc.create(name: '1000000', chainb: ro6)
    Chainc.create(name: '1500000', chainb: ro6)
    Chainc.create(name: '2000000', chainb: ro6)
    Chainc.create(name: '2500000', chainb: ro6)

    Chainc.create(name: '1000000', chainb: ro7)
    Chainc.create(name: '1500000', chainb: ro7)
    Chainc.create(name: '2000000', chainb: ro7)
    Chainc.create(name: '2500000', chainb: ro7)

    Chainc.create(name: '1500000', chainb: ro8)
    Chainc.create(name: '2000000', chainb: ro8)
    Chainc.create(name: '2500000', chainb: ro8)

    Chainc.create(name: '2000000', chainb: ro9)
    Chainc.create(name: '2500000', chainb: ro9)

    Chainc.create(name: '2500000', chainb: ro10)
    
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chaina.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainb.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainc.table_name}")
  end
end