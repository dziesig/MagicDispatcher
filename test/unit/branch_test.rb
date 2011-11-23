require 'test_helper'

class BranchTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty_name" do
    b = Branch.new(:name=>'')
    assert !b.valid?
    assert_equal "can't be blank",b.errors[:name][0]
    assert_equal 1,b.errors[:name].count
  end
  
  test "add_branch" do
    b = Branch.new(:name => 'Main Line', :railroad_id => 1)
    assert b.valid?
    assert_equal 'Main Line',b.name
    assert_equal 1,b.railroad_id
  end
    
  test "add_duplicate_branch" do
    b = Branch.new(:name => 'Branch 2 Railroad 1',:railroad_id => 1)
    assert !b.valid?
    assert_equal "has already been taken",b.errors[:name][0]
    assert_equal 1,b.errors[:name].count
  end
  
  test "add_duplicate_branch_to_different_railroad" do
    b = Branch.new(:name => 'Branch 2 Railroad 1',:railroad_id => 2)
    assert b.valid?
    assert_equal 'Branch 2 Railroad 1',b.name
    assert_equal 2,b.railroad_id
  end
end
