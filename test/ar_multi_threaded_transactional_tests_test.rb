require_relative "test_helper"

SingleCov.covered!

describe ArMultiThreadedTransactionalTests do
  def multithread_simple
    1000.times { User.create! } # need something slow ... sqlite does not have a sleep
    Array.new(10).map do
      Thread.new do
        begin
          10.times do
            User.all.map(&:name)
          end
          false
        rescue ActiveRecord::ConnectionTimeoutError
          true
        end
      end
    end.map(&:value)
  end

  def multithread_transactions
    Array.new(10).map do
      Thread.new do
        begin
          10.times do
            User.transaction do
              user = User.create!
              user.destroy!
            end
          end
          raise "Count is #{User.count}" unless User.count == 0
          false
        rescue ActiveRecord::ConnectionTimeoutError
          true
        end
      end
    end.map(&:value)
  end

  let(:all_timed_out) { Array.new(10).fill(true) }
  let(:all_finished) { Array.new(10).fill(false) }

  before { User.delete_all }

  it "has a VERSION" do
    ArMultiThreadedTransactionalTests::VERSION.must_match /^[\.\da-z]+$/
  end

  it "does not work with simple statements when not active" do
    multithread_simple.must_equal all_timed_out
  end

  it "works with simple statements when active" do
    ArMultiThreadedTransactionalTests.activate do
      multithread_simple.must_equal all_finished
    end
  end

  it "does not work with transactions when not active" do
    multithread_transactions.must_equal all_timed_out
  end

  it "works with transactions when active" do
    ArMultiThreadedTransactionalTests.activate do
      multithread_transactions.must_equal all_finished
    end
  end
end
