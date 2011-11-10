require 'test_helper'

require 'permission.rb'

class PermissionTest < ActiveSupport::TestCase

  test "empty_name" do
    p = Permission.new
    assert !p.valid?
    assert_equal "can't be blank",p.errors[:name][0]
  end
  
  test "duplicate_name" do
    p = Permission.new(:name => permissions(:one).name )
    assert !p.save
    assert_equal "has already been taken", p.errors[:name][0]
  end
end
