# typed: strict

require 'benchmark'
require 'sorbet-runtime'

module Test
  extend T::Sig
  SYM = T.let(:test, Symbol)

  sig {params(arr: T::Array[Integer]).returns(Symbol)}
  def self.test_with_array(arr)
    SYM
  end

  sig {params(hash: T::Hash[Integer, Symbol]).returns(Symbol)}
  def self.test_with_hash(hash)
    SYM
  end
end

array_1 = (1..1).to_a
array_10 = (1..10).to_a
array_100 = (1..100).to_a
array_1000 = (1..1_000).to_a
array_10000 = (1..10_000).to_a
array_100000 = (1..100_000).to_a
array_1000000 = (1..1_000_000).to_a

hash_1 = (1..1).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_10 = (1..10).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_100 = (1..100).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_1000 = (1..1_000).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_10000 = (1..10_000).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_100000 = (1..100_000).each_with_object({}){|i, h| h[i] = Test::SYM}
hash_1000000 = (1..1_000_000).each_with_object({}){|i, h| h[i] = Test::SYM}

test_times = 1_000
Benchmark.bmbm do |x|
  x.report('test array 1') { test_times.times {Test.test_with_array(array_1)}}
  x.report('test array 10') { test_times.times {Test.test_with_array(array_10)}}
  x.report('test array 100') { test_times.times {Test.test_with_array(array_100)}}
  x.report('test array 1000') { test_times.times {Test.test_with_array(array_1000)}}
  x.report('test array 10000') { test_times.times {Test.test_with_array(array_10000)}}
  x.report('test array 100000') { test_times.times {Test.test_with_array(array_100000)}}
  x.report('test array 1000000') { test_times.times {Test.test_with_array(array_1000000)}}
  x.report('test hash 1') { test_times.times {Test.test_with_hash(hash_1)}}
  x.report('test hash 10') { test_times.times {Test.test_with_hash(hash_10)}}
  x.report('test hash 100') { test_times.times {Test.test_with_hash(hash_100)}}
  x.report('test hash 1000') { test_times.times {Test.test_with_hash(hash_1000)}}
  x.report('test hash 10000') { test_times.times {Test.test_with_hash(hash_10000)}}
  x.report('test hash 100000') { test_times.times {Test.test_with_hash(hash_100000)}}
  x.report('test hash 1000000') { test_times.times {Test.test_with_hash(hash_1000000)}}
end
