require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty_name" do
    s = Section.new(:name=>'')
    assert !s.valid?
    assert_equal "can't be blank",s.errors[:name][0]
    assert_equal 1,s.errors[:name].count
  end
  
  test "add_section" do
    s = Section.new(:name => 'Main Line', :branch_id => 1)
    assert s.valid?
    assert_equal 'Main Line',s.name
    assert_equal 1,s.branch_id
  end
    
  test "add_duplicate_branch" do
    s = Section.new(:name => 'Section 2 Branch 1',:branch_id => 1)
    assert !s.valid?
    assert_equal "has already been taken",s.errors[:name][0]
    assert_equal 1,s.errors[:name].count
  end
  
  test "add_duplicate_branch_to_different_railroad" do
    s = Section.new(:name => 'Section 2 Branch 1',:branch_id => 2)
    assert s.valid?
    assert_equal 'Section 2 Branch 1',s.name
    assert_equal 2,s.branch_id
  end
end
