require 'test_helper'

class RailroadTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty_name" do
    r = Railroad.new(:name=>'')
    assert !r.valid?
    assert_equal "can't be blank",r.errors[:name][0]
    assert_equal 1,r.errors[:name].count
  end
  
  test "add_railroad" do
    r = Railroad.new(:name => 'Railroad 3', :user_id => 1)
    assert r.valid?
    assert_equal 'Railroad 3',r.name
    assert_equal 1,r.user_id
  end
    
  test "add_duplicate_railroad" do
    r = Railroad.new(:name => 'Railroad 1', :user_id => 2)
    assert !r.valid?
    assert_equal "has already been taken",r.errors[:name][0]
    assert_equal 1,r.errors[:name].count
  end
  
  # Insert a railroad with branches, sections and tracks.
  # make sure that they are all there, then delete the railroad
  # and make sure that they are all gone.
  
  test "enter_and_delete_railroad" do
    r = Railroad.new(:name => "Railroad Gone")
    assert r.save
    assert_equal "Railroad Gone",r.name
    railroad_id = r.id;
    r.branches << Branch.new(:name=>'Branch Gone 1')
    assert r.save
    r.branches << Branch.new(:name=>'Branch Gone 2')
    assert r.save
    assert_equal "Branch Gone 1", r.branches[1].name
    assert_equal "Branch Gone 2", r.branches[0].name
    branch_id_0 = r.branches[0].id
    branch_id_1 = r.branches[1].id
    r.branches[1].sections << Section.new(:name => 'Section Gone 1 1')
    section_id_0 = r.branches[1].sections[0].id
    r.branches[1].sections[0].tracks << Track.new(:name => 'Track Gone 1 1 1')
    track_id_0 = r.branches[1].sections[0].tracks[0].id
    
    assert Railroad.find(railroad_id)
    assert Branch.find(branch_id_0)
    assert Branch.find(branch_id_1)
    assert Section.find(section_id_0)
    assert Track.find(track_id_0)
    
    r.destroy;
    
    assert_raise(ActiveRecord::RecordNotFound) {Railroad.find(railroad_id)}
    assert_raise(ActiveRecord::RecordNotFound) {Branch.find(branch_id_0)}
    assert_raise(ActiveRecord::RecordNotFound) {Branch.find(section_id_0)}
    assert_raise(ActiveRecord::RecordNotFound) {Track.find(track_id_0)}
    
    
  end
    
    
end
