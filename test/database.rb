# connect
# TODO: we need a shared in-memory database but that somehow does not work
# https://www.sqlite.org/inmemorydb.html ... need to make 1 test fail if it is not shared so we do not accidentally pass
# with noop-tests
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "file::memory:?cache=shared",
  pool: 1, # make it blow up fast
  checkout_timeout: 1
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
