require 'active_record'

# Multithreaded code uses the same connection or we would escape our surrounding transactional fixtures.
# To make multiple threads not step on each other, we wrap each transaction and
# and each execution outside of a transaction in a lock, being careful not to lock multiple times when nesting.
module ArMultiThreadedTransactionalTests
  MUTEX = Mutex.new

  class << self
    attr_reader :active, :connection

    def activate
      if block_given?
        begin
          activate
          yield
        ensure
          deactivate
        end
      else
        @active = true
        @connection = ActiveRecord::Base.connection
      end
    end

    def deactivate
      @active = false
      @connection = nil
    end

    def synchronize
      if !active || Thread.current[:MultiThreadDbSyncerLocked]
        yield
      else
        MUTEX.synchronize do
          begin
            Thread.current[:MultiThreadDbSyncerLocked] = true
            yield
          ensure
            Thread.current[:MultiThreadDbSyncerLocked] = false
          end
        end
      end
    end
  end

  module TransactionSyncer
    def transaction(*)
      ArMultiThreadedTransactionalTests.synchronize { super }
    end
  end

  module ExecutionSyncer
    def log(*)
      ArMultiThreadedTransactionalTests.synchronize { super }
    end
  end

  module ConnectionSyncer
    def connection
      ArMultiThreadedTransactionalTests.connection || super
    end
  end
end

class << ActiveRecord::Base
  prepend ArMultiThreadedTransactionalTests::TransactionSyncer
  prepend ArMultiThreadedTransactionalTests::ConnectionSyncer
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.prepend ArMultiThreadedTransactionalTests::ExecutionSyncer
