require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "empty_name" do
    p = User.new
    assert !p.valid?
    assert_equal "can't be blank",p.errors[:name][0]
    assert_equal "is too short (minimum is 3 characters)",p.errors[:email_address][0]
  end
  
  test "duplicate_name" do
    p = User.new(:name => users(:one).name )
    assert !p.save
    assert_equal "has already been taken", p.errors[:name][0]
  end
  
  test "duplicate_email" do
    p = User.new(:name => (users(:one).name+'aaa'), :email_address => users(:one).email_address )
    assert !p.save
    assert_equal "has already been taken", p.errors[:email_address][0]
  end
  
  test "two_users" do
    assert_equal User.count,2
  end
end
