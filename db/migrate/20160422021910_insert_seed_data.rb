class InsertSeedData < ActiveRecord::Migration
  def up
    # creating some sample data

    my = Place.create(name: 'Malaysia')
    uk = Place.create(name: 'United Kingdom') 

    myse = Region.create(name: 'Selangor', place: my) 
    mysa = Region.create(name: 'Sabah', place: my)
    ukcb = Region.create(name: 'Cumbria', place: uk)
    ukny = Region.create(name: 'North Yorkshire', place: uk)

    Area.create(name: 'Kajang', region: myse)
    Area.create(name: 'Cheras', region: myse)
    Area.create(name: 'Setapak', region: myse)

    Area.create(name: 'Sandakan', region: mysa)
    Area.create(name: 'Tawau', region: mysa)

    Area.create(name: 'Wigton', region: ukcb)
    Area.create(name: 'Penrith', region: ukcb) 

    Area.create(name: 'Harrogate', region: ukny) 
  end

  def down
    ActiveRecord::Base.connection.execute("TRUNCATE #{Area.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Region.table_name}")
    ActiveRecord::Base.connection.execute("TRUNCATE #{Place.table_name}")
  end
end
