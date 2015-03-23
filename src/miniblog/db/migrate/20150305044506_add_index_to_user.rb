class AddIndexToUser < ActiveRecord::Migration
  def change
    execute("ALTER TABLE users ADD FULLTEXT(`username`);")
    execute("ALTER TABLE users ADD FULLTEXT(`first_name`);")
    execute("ALTER TABLE users ADD FULLTEXT(`last_name`);")
  end
end