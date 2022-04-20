require 'test/unit'

require 'uio/content'

class Test_content < Test::Unit::TestCase

  def test_links
    l = (UIO::Content.new <<~EOT
        [example link](http://example.com/)
        ![alt text](/path/to/img.jpg)
        [example link](http://example.com/ "With a Title")
        ![alt text](/path/to/img.jpg "Title")
        example [link](http://example.com/)
      EOT
    ).links

    assert_equal 3, l.size
    assert_equal ['example link', 'http://example.com/'], l[0]
    assert_equal ['example link', 'http://example.com/', 'With a Title'], l[1]
    assert_equal ['link', 'http://example.com/'], l[2]
  end

end
