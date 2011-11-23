require 'test_helper'

class TrackTest < ActiveSupport::TestCase

  fixtures :track_connections

  test "empty_name" do
    s = Track.new(:name=>'')
    assert !s.valid?
    assert_equal "can't be blank",s.errors[:name][0]
    assert_equal 1,s.errors[:name].count
  end
  
  test "add_track" do
    s = Track.new(:name => 'Zanesville Main', :section_id => 1)
    assert s.valid?
    assert_equal 'Zanesville Main',s.name
    assert_equal 1,s.section_id
  end
    
  test "add_duplicate_track" do
    s = Track.new(:name => 'Track 2 Section 1',:section_id => 1)
    assert !s.valid?
    assert_equal "has already been taken",s.errors[:name][0]
    # assert_equal "has already been taken",s.errors[:name][1]
    assert_equal 1,s.errors[:name].count
  end
  
  test "add_duplicate_track_to_different_section" do
    s = Track.new(:name => 'Track 2 Section 1',:section_id => 2)
    assert s.valid?
    assert_equal 'Track 2 Section 1',s.name
    assert_equal 2,s.section_id
  end
  
  test "connect_two_tracks" do
     
    t10 = Track.new(:name=>'Track 10', :track_type_id => 1)  # a Through track
    t10.save!
    
    t11 = Track.new(:name=>'Track 11', :track_type_id => 1)
    t11.save!

    t10.cl = t11
    tt = TrackConnection.find_by_name('CR')
 
    t10.cl_ext = TrackConnection.find_by_name('CR')
    
    
    assert_nil t11.cr
    assert_nil t11.cr_ext
    
    t10.save!
    
    assert_equal t10,t11.cr
    assert_equal TrackConnection.find_by_name('CL').id,t11.cr_ext_id
    
  end
    
  test "connect_two_tracks_then_destroy" do
     
    t10 = Track.new(:name=>'Track 10', :track_type_id => 1)  # a Through track
    t10.save!
    
    t11 = Track.new(:name=>'Track 11', :track_type_id => 1)
    t11.save!

    t10.cl = t11
    tt = TrackConnection.find_by_name('CR')
 
    t10.cl_ext = TrackConnection.find_by_name('CR')
    
    
    assert_nil t11.cr
    assert_nil t11.cr_ext
    
    t10.save!
    
    assert_equal t10,t11.cr
    assert_equal TrackConnection.find_by_name('CL').id,t11.cr_ext_id
    
    t10.destroy    
    
    t11 = Track.find(t11.id)
    assert_nil t11.cr
    assert_nil t11.cr_ext
        
  end
    
end
