require 'test/unit'

require 'uio/yaml_front_matter'

class Test_content < Test::Unit::TestCase

  def test_empty
    assert_nil UIO.parse_yaml_front_matter('')
  end

  def test_circular
    [
      "---\n---\n",
      "---\n---\nb",
      "---\n---\nb\n",

      "---\na: 1\n---\n",
      "---\na: 1\n---\nb",
      "---\na: 1\n---\nb\n",

      "---\n---\n ",
      "---\n---\n\n ",
      "---\n---\n \n",
      "---\n---\n\n \n",

    ].each do |text|
      assert_equal text, UIO.dump_yaml_front_matter(UIO.parse_yaml_front_matter(text))
    end
  end

end
