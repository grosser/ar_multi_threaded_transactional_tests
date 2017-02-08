# connect
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# create tables
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.string :name
  end
end

class User < ActiveRecord::Base
end
