class Animal

  attr_accessor :id, :Scientific_Animal_Name, :Common_Animal_Name

  def self.open_connection

    conn = PG.connect( dbname: 'animals2')

  end

  def self.all

    conn = self.open_connection

    sql = "SELECT * FROM animal ORDER BY id"

    results = conn.exec(sql)

    animals = results.map do |tuple|
      self.hydrate tuple
    end

  end

  def self.find id

    conn = self.open_connection

    sql = "SELECT * FROM animal WHERE id=#{ id } LIMIT 1"

    animals = conn.exec(sql)

    animal = self.hydrate animals[0]

    animal

  end

  def save

    conn = Animal.open_connection

    if (!self.id)
      sql = "INSERT INTO animal (Scientific_Animal_Name, Common_Animal_Name) VALUES ('#{ self.Scientific_Animal_Name }','#{ self.Common_Animal_Name }')"
    else
      sql = "UPDATE animals SET Scientific_Animal_Name='#{self.Scientific_Animal_Name}', Common_Animal_Name='#{self.Common_Animal_Name}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)

  end

  def self.destroy id
    conn = self.open_connection

    sql = "DELETE FROM animal WHERE id=#{id}"

    conn.exec(sql)
  end

  def self.hydrate animal_data

    animal = Animal.new

    animal.id = animal_data['id']
    animal.Scientific_Animal_Name = animal_data['Scientific_Animal_Name']
    animal.Common_Animal_Name = animal_data['Common_Animal_Name']

    animal

  end

end
