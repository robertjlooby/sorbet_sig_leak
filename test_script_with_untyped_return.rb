# typed: strict

require 'ruby-prof'
require 'sorbet-runtime'

module Test
  extend T::Sig
  EVEN = T.let(:even, Symbol)
  ODD = T.let(:odd, Symbol)

  sig {params(num: Integer).returns(T.untyped)}
  def self.test_with_untyped_return(num)
    if num.even?
      EVEN
    else
      ODD
    end
  end
end

result = RubyProf.profile(:track_allocations => true) do
  1_000_000.times do |i|
    Test.test_with_untyped_return(i)
  end
end

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(File.new('./test_with_untyped_return.html', 'w'), :min_percent=>0)
