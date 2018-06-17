class Plant

  attr_accessor :id, :Scientific_Plant_Name, :Common_Plant_Name

  def self.open_connection

    conn = PG.connect( dbname: 'plants')

  end

  def self.all

    conn = self.open_connection

    sql = "SELECT * FROM plant ORDER BY id"

    results = conn.exec(sql)

    plants = results.map do |tuple|
      self.hydrate tuple
    end

  end

  def self.find id

    conn = self.open_connection

    sql = "SELECT * FROM plant WHERE id=#{ id } LIMIT 1"

    plants = conn.exec(sql)

    plant = self.hydrate plants[0]

    plant

  end

  def save

    conn = Plant.open_connection

    if (!self.id)
      sql = "INSERT INTO plant (Scientific_Plant_Name, Common_Plant_Name) VALUES ('#{ self.Scientific_Plant_Name }','#{ self.Common_Plant_Name }')"
    else
      sql = "UPDATE plants SET Scientific_Plant_Name='#{self.Scientific_Plant_Name}', Common_Plant_Name='#{self.Common_Plant_Name}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)

  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM plant WHERE id=#{id}"

    conn.exec(sql)
  end

  def self.hydrate animal_data

    plant = Plant.new

    plant.id = animal_data['id']
    plant.Scientific_Plant_Name = animal_data['Scientific_Plant_Name']
    plant.Common_Plant_Name = animal_data['Common_Plant_Name']

    plant

  end

end
