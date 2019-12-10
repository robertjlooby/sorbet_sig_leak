# typed: strong

require 'sorbet-runtime'


module Test
  extend T::Sig
  SYM = T.let(:test, Symbol)

  sig {returns(Symbol)}
  def self.test
    SYM
  end
end

1_000_000.times do
  Test.test
end
