require_relative "test_helper"

SingleCov.covered!

describe ArMultiThreadedTransactionalTests do
  def multithread_simple
    1000.times { User.create! } # need something slow ... sqlite does not have a sleep
    Array.new(10).map do
      Thread.new do
        10.times do
          User.all.map(&:name)
        end
      end
    end.each(&:join)
  end

  def multithread_transactions
    Array.new(10).map do
      Thread.new do
        10.times do
          User.transaction do
            user = User.create!
            user.destroy!
          end
        end
        raise "Count is #{User.count}" unless User.count == 0
      end
    end.each(&:join)
  end

  before { User.delete_all }

  it "has a VERSION" do
    ArMultiThreadedTransactionalTests::VERSION.must_match /^[\.\da-z]+$/
  end

  it "does not work with simple statements when not active" do
    assert_raises(ActiveRecord::StatementInvalid) { multithread_simple }
  end

  it "works with simple statements when active" do
    ArMultiThreadedTransactionalTests.activate { multithread_simple }
  end

  it "does not work with transactions when not active" do
    assert_raises(ActiveRecord::StatementInvalid) { multithread_transactions }
  end

  it "works with transactions when active" do
    ArMultiThreadedTransactionalTests.activate { multithread_transactions }
  end
end
