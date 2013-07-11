require 'test_helper'

class HelloWordTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, HelloWord
  end

  test "hello" do
    assert_equal "squawk! Hello World", "Hello World".to_squawk
  end
end
