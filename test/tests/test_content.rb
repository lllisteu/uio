require 'test/unit'

require 'uio/content'

class Test_content < Test::Unit::TestCase

  def test_links
    l = (UIO::Content.new <<~EOT
        [example link](http://example.com/)
        [example link](http://example.com/ "With a Title")
      EOT
    ).links
    assert_equal ['example link', 'http://example.com/'], l[0]
    assert_equal ['example link', 'http://example.com/', 'With a Title'], l[1]
  end

end
