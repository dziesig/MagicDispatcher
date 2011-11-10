require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  
  test "empty_name" do
    p = Role.new
    assert !p.valid?
    assert_equal "can't be blank",p.errors[:name][0]
  end
  
  test "duplicate_name" do
    p = Role.new(:name => roles(:one).name )
    assert !p.save
    assert_equal "has already been taken", p.errors[:name][0]
  end
end
