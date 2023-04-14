require 'sqlite3'

# create test_guru database
db = SQLite3::Database.new('test_guru.db')

# create categories table
db.execute(
  "CREATE TABLE categories (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL
  );"
)

# create tests table
db.execute(
  "CREATE TABLE tests (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    level INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
  );"
)

# create questions table
db.execute(
  "CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    body TEXT NOT NULL,
    test_id INTEGER NOT NULL,
    FOREIGN KEY (test_id) REFERENCES tests(id)
  );"
)

# Create 3 rows in the categories table
db.execute("INSERT INTO categories (title) VALUES ('Technology'), ('Science'), ('History');")

# Create 5 rows in the tests table (at least 3 with non-null foreign key to categories table)
db.execute("INSERT INTO tests (title, level, category_id) VALUES ('MySQL Basics', 1, 1), ('Python Programming', 2, 1), ('Physics 101', 1, 2), ('Biology Quiz', 3, 2), ('World War II', 2, 3);")

# Create 5 rows in questions table
db.execute("INSERT INTO questions (body, test_id) VALUES ('What is a primary key?', 1), ('What is the difference between a list and a tuple in Python?', 2), ('What is the formula for calculating force?', 3), ('What is the process of cell division called?', 4), ('What were the major causes of World War II?', 5);")

# Select all tests with level 2 and 3
db.execute("SELECT * FROM tests WHERE level IN (2, 3);") 

# Select all questions for a specific test
db.execute("SELECT * FROM questions WHERE test_id = 1;")

# Update the title and level attributes for a row from the tests table with a single query
db.execute("UPDATE tests SET title = 'Advanced MySQL', level = 2 WHERE id = 1;")

# Remove all questions for a specific test with a single request
db.execute("DELETE FROM questions WHERE test_id = 4;")

# Use JOIN to select the names of all tests and the names of their categories
db.execute("
  SELECT tests.title AS test_title, categories.title AS category_title 
  FROM tests
  JOIN categories ON tests.category_id = categories.id;
") 

# Using JOIN, select the content of all questions (the body attribute) and the names of the tests associated with them
db.execute("
  SELECT questions.body, tests.title 
  FROM questions
  JOIN tests ON questions.test_id = tests.id;
") do |element|
puts element
puts "---------------------"
end

db.close
