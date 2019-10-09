class Dog

  attr_accessor :id, :name, :breed
  #attr_reader :id

  def initialize (id: nil, name:, breed:)
    #dog = Dog.new HUH?
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
        )
      SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end

  def save
    # "if self.id" ... business needed here?
    sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
        SQL
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
      self
  end

  def self.create (hash)
    dog = Dog.new
    dog.name = hash[:name]
    dog.breed = hash[:breed]
    dog.save
  end

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    Dog.new(id: id, name: name, breed: breed)
  end

  def find_by_id
  end

  def find_or_create_by
  end

  def self.find_by_name(name) #WILL NOT WORK UNTIL SAVE WORKS
    sql = "SELECT * FROM dogs WHERE name = ?"
    result = DB[:conn].execute(sql, name)
    new_from_db(result[0])
  end


  def update
  end

end
