class InsertSeedData4 < ActiveRecord::Migration
  def up
    ro = Chaina.create(name: 'SqM')

    ro1 = Chainb.create(name:   '100', chaina: ro) 
    ro2 = Chainb.create(name:   '200', chaina: ro)
    ro3 = Chainb.create(name:   '300', chaina: ro) 
    ro4 = Chainb.create(name:   '400', chaina: ro)    
    ro5 = Chainb.create(name:   '500', chaina: ro) 

    Chainc.create(name:  '100', chainb: ro1)
    Chainc.create(name:  '200', chainb: ro1)
    Chainc.create(name:  '300', chainb: ro1)
    Chainc.create(name:  '400', chainb: ro1)
    Chainc.create(name:  '500', chainb: ro1)


    Chainc.create(name:  '200', chainb: ro2)
    Chainc.create(name:  '300', chainb: ro2)
    Chainc.create(name:  '400', chainb: ro2)
    Chainc.create(name:  '500', chainb: ro2)

    Chainc.create(name:  '300', chainb: ro3)
    Chainc.create(name:  '400', chainb: ro3)
    Chainc.create(name:  '500', chainb: ro3)

    Chainc.create(name:  '400', chainb: ro4)
    Chainc.create(name:  '500', chainb: ro4)

    Chainc.create(name:  '500', chainb: ro5)
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chaina.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainb.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainc.table_name}")
  end
end