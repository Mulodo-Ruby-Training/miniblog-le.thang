class AddIndexToUser < ActiveRecord::Migration
  def change
    execute("ALTER TABLE users ENGINE = MYISAM;")
    execute("ALTER TABLE users ADD FULLTEXT INDEX username(username);")
    execute("ALTER TABLE users ADD FULLTEXT INDEX first_name(first_name);")
    execute("ALTER TABLE users ADD FULLTEXT INDEX last_name(last_name);")
  end
end
