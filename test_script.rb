# typed: strict

require 'ruby-prof'
require 'sorbet-runtime'

module Test
  extend T::Sig
  SYM = T.let(:test, Symbol)

  sig {returns(Symbol)}
  def self.test
    SYM
  end
end

result = RubyProf.profile(:track_allocations => true) do
  1_000_000.times do
    Test.test
  end
end

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(File.new('./test.html', 'w'), :min_percent=>0)
