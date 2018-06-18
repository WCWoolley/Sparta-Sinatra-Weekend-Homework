class Plant

  attr_accessor :id, :scientific_plant_name, :common_plant_name

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
      sql = "INSERT INTO plant (scientific_plant_name, common_plant_name) VALUES ('#{ self.scientific_plant_name }','#{ self.common_plant_name }')"
    else
      sql = "UPDATE plants SET scientific_plant_name='#{self.scientific_plant_name}', common_plant_name='#{self.common_plant_name}' WHERE id='#{self.id}'"
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
    plant.scientific_plant_name = animal_data['scientific_plant_name']
    plant.common_plant_name = animal_data['common_plant_name']

    plant

  end

end
