class Student

  attr_reader :name, :grade, :id

  def initialize(name, grade, id= nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE students;
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES ('#{self.name}', '#{self.grade}');
    SQL

    DB[:conn].execute(sql)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  #
  def self.create(hash)
    student = self.new(hash[:name], hash[:grade])
    student.save
    student
  end





  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
