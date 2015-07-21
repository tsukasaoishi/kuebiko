require 'test_helper'

class PreparationBuildTest < Minitest::Test
  def build(*paths, **options)
    Kuebiko::Preparation.new(paths, options).build
  end

  test "no arguments returns empty string" do
    assert_equal "", build
  end

  test "String object returns itself" do
    argument = SecureRandom.hex(10)
    assert_equal argument, build(argument)
  end

  test "Symbol object returns value that be converted to String" do
    argument = SecureRandom.hex(10)
    assert_equal argument, build(argument.to_sym)
  end

  test "Fixnum object returns value that be converted to String" do
    argument = rand(100000)
    assert_equal argument.to_s, build(argument)
  end

  test "multiple arguments are joined by slash" do
    arguments = []
    rand(100).times{ arguments << SecureRandom.hex(10) }
    rand(100).times{ arguments.insert(rand(arguments.size), SecureRandom.hex(10).to_sym) }
    rand(100).times{ arguments.insert(rand(arguments.size), rand(100000)) }
    correct_val = arguments.each_with_object(""){|a, v| v << "#{a}/"}[0..-2]
    assert_equal correct_val, build(*arguments)
  end

  test "arguments are escaped" do
    arguments = ["a/b:c d&e=f", "g<h>i"]
    assert_equal "a%2Fb%3Ac+d%26e%3Df/g%3Ch%3Ei", build(*arguments)
  end

  test "query options adds as query parameter" do
    query = {one: rand(100), "two" => SecureRandom.hex(10), 3 => SecureRandom.hex(10).to_sym}
    correct_val = query.sort_by{|k,v| k.to_s}.each_with_object(""){|(k,v), val| val << "#{k}=#{v}&"}[0..-2]
    assert_equal "?#{correct_val}", build(query: query)
  end

  test "query parameter is escaped" do
    query = {'a:b' => 'c d'}
    assert_equal '?a%3Ab=c+d', build(query: query)

    query = {person: {name: 'Tsukasa', sei: 'Oishi'}}
    assert_equal '?person%5Bname%5D=Tsukasa&person%5Bsei%5D=Oishi', build(query: query)

    query = {person: {id: 10}, account: {person: {id: 20}}}
    assert_equal '?account%5Bperson%5D%5Bid%5D=20&person%5Bid%5D=10', build(query: query)

    query = {person: {id: [10, 20]}}
    assert_equal '?person%5Bid%5D%5B%5D=10&person%5Bid%5D%5B%5D=20', build(query: query)
  end

  test "anchor options adds as anchor" do
    anchor = SecureRandom.hex(10)
    assert_equal "##{anchor}", build(anchor: anchor)
  end

  test "anchor is escaped" do
    anchor = 'a:bc d'
    assert_equal '#a%3Abc+d', build(anchor: anchor)
  end

  test "trailing_slash option" do
    assert_equal "", build(trailing_slash: true)

    argument = SecureRandom.hex(10)
    assert_equal "#{argument}/", build(argument, trailing_slash: true)
  end

  test "arguments and query and anchor and trailing_slash" do
    argument = SecureRandom.hex(10)
    query = {tsu: 1}
    anchor = SecureRandom.hex(8)

    assert_equal "#{argument}?tsu=1", build(argument, query: query)
    assert_equal "?tsu=1##{anchor}", build(query: query, anchor: anchor)
    assert_equal "#{argument}##{anchor}", build(argument, anchor: anchor)
    assert_equal "#{argument}?tsu=1##{anchor}", build(argument, query: query, anchor: anchor)

    assert_equal "#{argument}/?tsu=1", build(argument, query: query, trailing_slash: true)
    assert_equal "?tsu=1##{anchor}", build(query: query, anchor: anchor, trailing_slash: true)
    assert_equal "#{argument}/##{anchor}", build(argument, anchor: anchor, trailing_slash: true)
    assert_equal "#{argument}/?tsu=1##{anchor}", build(argument, query: query, anchor: anchor, trailing_slash: true)
  end
end
