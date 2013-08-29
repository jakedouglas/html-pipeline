# encoding: utf-8
require "test_helper"

class HTML::Pipeline::UTF8FilterTest < Test::Unit::TestCase
  UTF8Filter = HTML::Pipeline::UTF8Filter

  def test_converts_long_non_utf8_when_possible
    non_utf8 = "blah blah yea uh huh yup \xE7\xF5 ta da"

    result = UTF8Filter.call(non_utf8)

    assert_equal "blah blah yea uh huh yup çõ ta da", result
    assert_equal Encoding::UTF_8, result.encoding
  end

  def test_cleans_short_non_utf8
    non_utf8 = "yup \xE7\xF5 ta da"

    result = UTF8Filter.call(non_utf8)

    assert_equal "yup �� ta da", result
    assert_equal Encoding::UTF_8, result.encoding
  end

  def test_leaves_short_utf8_alone
    utf8 = "blahblah"

    result = UTF8Filter.call(utf8)

    assert_equal "blahblah", result
    assert_equal Encoding::UTF_8, result.encoding
  end
end
