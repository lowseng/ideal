class InsertSeedData3 < ActiveRecord::Migration
  def up
    ro = Chaina.create(name: 'SqFt')

    ro1 = Chainb.create(name:   '1000', chaina: ro) 
    ro2 = Chainb.create(name:   '2000', chaina: ro)
    ro3 = Chainb.create(name:   '3000', chaina: ro) 
    ro4 = Chainb.create(name:   '4000', chaina: ro)    
    ro5 = Chainb.create(name:   '5000', chaina: ro) 

    Chainc.create(name:  '1000', chainb: ro1)
    Chainc.create(name:  '2000', chainb: ro1)
    Chainc.create(name:  '3000', chainb: ro1)
    Chainc.create(name:  '4000', chainb: ro1)
    Chainc.create(name:  '5000', chainb: ro1)


    Chainc.create(name:  '2000', chainb: ro2)
    Chainc.create(name:  '3000', chainb: ro2)
    Chainc.create(name:  '4000', chainb: ro2)
    Chainc.create(name:  '5000', chainb: ro2)

    Chainc.create(name:  '3000', chainb: ro3)
    Chainc.create(name:  '4000', chainb: ro3)
    Chainc.create(name:  '5000', chainb: ro3)

    Chainc.create(name:  '4000', chainb: ro4)
    Chainc.create(name:  '5000', chainb: ro4)

    Chainc.create(name:  '5000', chainb: ro5)
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chaina.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainb.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Chainc.table_name}")
  end
end