# typed: ignore

require 'ruby-prof'
require 'sorbet-runtime'

module Test
  extend T::Sig
  EVEN = T.let(:even, Symbol)
  ODD = T.let(:odd, Symbol)

  sig {params(num: Integer).returns(Symbol)}
  def self.test_with_params(num)
    if num.even?
      EVEN
    else
      ODD
    end
  end
end

result = RubyProf.profile(:track_allocations => true) do
  1_000_000.times do |i|
    Test.test_with_params(i)
  end
end

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(File.new('./test_with_params.html', 'w'), :min_percent=>0)
