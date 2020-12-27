Execute multithreaded code while still using transactional fixtures by synchronizing db access to a single connection

Install
=======

```Bash
gem install ar_multi_threaded_transactional_tests
```

Usage
=====

```Ruby
require 'ar_multi_threaded_transactional_tests'

it "stays in sync" do
  ArMultiThreadedTransactionalTests.activate do
    Array.new(10).map { Thread.new { 10.times { User.create! } } }.each(&:join)
  end
end
```

Alternatively use `.activate` and `.deactivate`

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
License: MIT<br/>
![CI](https://github.com/grosser/ar_multi_threaded_transactional_tests/workflows/CI/badge.svg)
