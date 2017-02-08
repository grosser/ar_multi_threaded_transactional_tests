require "spec_helper"

SingleCov.covered!

describe ArMultiThreadedTransactionalTests do
  it "has a VERSION" do
    expect(ArMultiThreadedTransactionalTests::VERSION).to match(/^[\.\da-z]+$/)
  end
end
