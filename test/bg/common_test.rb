require 'test_helper'

class BG::CommonTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BG::Common::VERSION
  end
end
