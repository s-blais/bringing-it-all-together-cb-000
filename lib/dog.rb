class Dog

  attr_accessor :id, :name, :breed
  #attr_reader :id

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

  def initialize (id: nil, name:, breed:)
    #dog = Dog.new HUH?
    @id = id
    @name = name
    @breed = breed
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS dogs")
  end

  def new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    Dog.new(id: id, name: name, breed: breed)
  end



end
