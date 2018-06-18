class Animal

  attr_accessor :id, :scientific_animal_name, :common_animal_name

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
      sql = "INSERT INTO animal (scientific_animal_name, common_animal_name) VALUES ('#{ self.scientific_animal_name }','#{ self.common_animal_name }')"
    else
      sql = "UPDATE animals SET scientific_animal_name='#{self.scientific_animal_name}', common_animal_name='#{self.common_animal_name}' WHERE id='#{self.id}'"
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
    animal.scientific_animal_name = animal_data['scientific_animal_name']
    animal.common_animal_name = animal_data['common_animal_name']

    animal

  end

end
