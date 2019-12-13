# typed: strict

require 'benchmark'
require 'sorbet-runtime'

module Parent
  extend T::Helpers
  sealed!
end

class Child1; include Parent; end
class Child2; include Parent; end

module Test
  extend T::Sig
  SYM = T.let(:test, Symbol)

  sig {returns(Symbol)}
  def self.test
    SYM
  end

  sig {params(num: Integer).returns(Symbol)}
  def self.test_with_params(num)
    SYM
  end

  sig {params(num: T.untyped).returns(Symbol)}
  def self.test_with_untyped_params(num)
    SYM
  end

  sig {params(num: Integer).returns(T.untyped)}
  def self.test_with_untyped_return(num)
    SYM
  end

  sig {params(arg: T::Hash[Symbol, Symbol]).returns(Symbol)}
  def self.test_with_hash(arg)
    SYM
  end

  sig {params(arg: T::Hash[Symbol, T.untyped]).returns(Symbol)}
  def self.test_with_untyped_hash(arg)
    SYM
  end

  sig {params(arg: T.any(Integer, Symbol)).returns(Symbol)}
  def self.test_with_any(arg)
    SYM
  end

  sig {params(arg: T::Hash[Symbol, T.any(Integer, Symbol)]).returns(Symbol)}
  def self.test_with_any_hash(arg)
    SYM
  end

  sig {params(arg1: T::Hash[Symbol, T.untyped], arg2: T::Hash[Symbol, T.any(Integer, Symbol)]).returns(Symbol)}
  def self.test_with_untyped_and_any_hash(arg1, arg2)
    SYM
  end

  sig {params(arg1: T::Hash[Symbol, T.untyped], arg2: T::Hash[Symbol, T.any(Integer, Symbol)]).void}
  def self.test_with_untyped_and_any_hash_void(arg1, arg2)
    SYM
  end

  sig {params(arg1: T::Hash[Symbol, T.untyped], arg2: T::Hash[Symbol, Parent]).void}
  def self.test_with_untyped_and_sealed_hash_void(arg1, arg2)
    SYM
  end

  sig {params(arg1: T::Hash[Symbol, T.untyped], arg2: T::Hash[Symbol, T.any(Child1, Child2)]).void}
  def self.test_with_untyped_and_any_sealed_hash_void(arg1, arg2)
    SYM
  end
end

Benchmark.bmbm do |x|
  x.report('test') { 1_000_000.times {Test.test}}
  x.report('test_with_params') { 1_000_000.times {|i| Test.test_with_params(i)}}
  x.report('test_with_untyped_params') { 1_000_000.times {|i| Test.test_with_untyped_params(i)}}
  x.report('test_with_untyped_return') { 1_000_000.times {|i| Test.test_with_untyped_return(i)}}
  x.report('test_with_hash') { h = {Test::SYM => Test::SYM}; 1_000_000.times {Test.test_with_hash(h)}}
  x.report('test_with_untyped_hash') { h = {Test::SYM => Test::SYM}; 1_000_000.times {Test.test_with_untyped_hash(h)}}
  x.report('test_with_any') { 1_000_000.times {Test.test_with_any(Test::SYM)}}
  x.report('test_with_any_hash') { h = {Test::SYM => Test::SYM}; 1_000_000.times {Test.test_with_any_hash(h)}}
  x.report('test_with_untyped_and_any_hash') { h = {Test::SYM => Test::SYM}; 1_000_000.times {Test.test_with_untyped_and_any_hash(h, h)}}
  x.report('test_with_untyped_and_any_hash_void') { h = {Test::SYM => Test::SYM}; 1_000_000.times {Test.test_with_untyped_and_any_hash_void(h, h)}}
  x.report('test_with_untyped_and_sealed_hash_void') { h = {Test::SYM => Child1.new}; 1_000_000.times {Test.test_with_untyped_and_sealed_hash_void(h, h)}}
  x.report('test_with_untyped_and_any_sealed_hash_void') { h = {Test::SYM => Child1.new}; 1_000_000.times {Test.test_with_untyped_and_any_sealed_hash_void(h, h)}}
end
