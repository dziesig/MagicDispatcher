class Track < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name        :string, :required
    
    track_class enum_string('Main','Passing','Yard/Siding')
    length      :integer, :required
    
    #the following are connections to other tracks
    ul_id       :integer, :index
    cl_id       :integer, :index
    ll_id       :integer, :index
    ur_id       :integer, :index
    cr_id       :integer, :index
    lr_id       :integer, :index
    ul_ext_id   :integer
    cl_ext_id   :integer
    ll_ext_id   :integer
    ur_ext_id   :integer
    cr_ext_id   :integer
    lr_ext_id   :integer
    timestamps
  end

  belongs_to :section, :creator => true
  
  belongs_to :track_type
  
  belongs_to  :ul_ext,    :class_name => "TrackConnection", :foreign_key => :ul_ext_id
  belongs_to  :cl_ext,    :class_name => "TrackConnection", :foreign_key => :cl_ext_id
  belongs_to  :ll_ext,    :class_name => "TrackConnection", :foreign_key => :ll_ext_id
  belongs_to  :ur_ext,    :class_name => "TrackConnection", :foreign_key => :ur_ext_id
  belongs_to  :cr_ext,    :class_name => "TrackConnection", :foreign_key => :cr_ext_id
  belongs_to  :lr_ext,    :class_name => "TrackConnection", :foreign_key => :lr_ext_id
  
  validates_uniqueness_of :name, :scope => :section_id
  
  # --- Connections --- #
  
  belongs_to  :ul,        :class_name => "Track", :foreign_key => :ul_id
  has_one     :ul_track,  :class_name => "Track", :foreign_key => :ul_id
  
  belongs_to  :cl,        :class_name => "Track", :foreign_key => :cl_id
  has_one     :cl_track,  :class_name => "Track", :foreign_key => :cl_id
  
  belongs_to  :ll,        :class_name => "Track", :foreign_key => :ll_id
  has_one     :ll_track,  :class_name => "Track", :foreign_key => :ll_id
  
  belongs_to  :ur,        :class_name => "Track", :foreign_key => :ur_id
  has_one     :ur_track,  :class_name => "Track", :foreign_key => :ur_id
  
  belongs_to  :cr,        :class_name => "Track", :foreign_key => :cr_id
  has_one     :cr_track,  :class_name => "Track", :foreign_key => :cr_id
  
  belongs_to  :lr,        :class_name => "Track", :foreign_key => :lr_id
  has_one     :lr_track,  :class_name => "Track", :foreign_key => :lr_id
  
  def external_connections(conn)
    result = Array.new()
    case conn
    when TrackType::UL
      if !ul.nil?
        track = self.ul      
        result << TrackConnection.find_by_name('UR') if track.track_type.has_connection?(TrackType::UR)
        result << TrackConnection.find_by_name('CR') if track.track_type.has_connection?(TrackType::CR)
        result << TrackConnection.find_by_name('LR') if track.track_type.has_connection?(TrackType::LR)
      end
    when TrackType::CL
      if !cl.nil?
        track = self.cl      
        result << TrackConnection.find_by_name('UR') if track.track_type.has_connection?(TrackType::UR)
        result << TrackConnection.find_by_name('CR') if track.track_type.has_connection?(TrackType::CR)
        result << TrackConnection.find_by_name('LR') if track.track_type.has_connection?(TrackType::LR)
      end
    when TrackType::LL
      if !ll.nil?
        track = self.ll      
        result << TrackConnection.find_by_name('UR') if track.track_type.has_connection?(TrackType::UR)
        result << TrackConnection.find_by_name('CR') if track.track_type.has_connection?(TrackType::CR)
        result << TrackConnection.find_by_name('LR') if track.track_type.has_connection?(TrackType::LR)
      end
    when TrackType::UR
      if !ur.nil?
        track = self.ur      
        result << TrackConnection.find_by_name('UL') if track.track_type.has_connection?(TrackType::UL)
        result << TrackConnection.find_by_name('CL') if track.track_type.has_connection?(TrackType::CL)
        result << TrackConnection.find_by_name('LL') if track.track_type.has_connection?(TrackType::LL)
      end
    when TrackType::CR
      ZLogger::puts "CR"
      if !cr.nil?
        ZLogger::puts "cr not nil"
        track = self.cr     
        ZLogger::puts "track type #{track.track_type.name}"
        result << TrackConnection.find_by_name('UL') if track.track_type.has_connection?(TrackType::UL)
        result << TrackConnection.find_by_name('CL') if track.track_type.has_connection?(TrackType::CL)
        result << TrackConnection.find_by_name('LL') if track.track_type.has_connection?(TrackType::LL)
      end
    when TrackType::LR
      if !lr.nil?
        track = self.lr      
        result << TrackConnection.find_by_name('UL') if track.track_type.has_connection?(TrackType::UL)
        result << TrackConnection.find_by_name('CL') if track.track_type.has_connection?(TrackType::CL)
        result << TrackConnection.find_by_name('LL') if track.track_type.has_connection?(TrackType::LL)
      end
    end
    ZLogger::puts "external_connections:  #{result.inspect}"
    result
  end
  
  after_save :disconnect_then_reconnect
  before_destroy :disconnect_it
  
  def disconnect_then_reconnect
    disconnect
    connect
  end
  
  def disconnect_it
    self.disconnect
    hack = 0 # THIS IS A HACK - WITHOUT IT THE DELETE DOES NOT OCCUR!
  end
  
  @@recursion = false
  
  def connect #connects all tracks that should be connected to this
    return if @@recursion
    @@recursion = true
    # there must be a better way to do this, but for now....
    track = ul
    modified = false
    if ul_ext == TrackConnection.find_by_name('UR')
      track.ur = self
      track.ur_ext = TrackConnection.find_by_name('UL')
      modified = true
    elsif ul_ext == TrackConnection.find_by_name('CR')
      track.cr = self
      track.cr_ext = TrackConnection.find_by_name('UL')
      modified = true
    elsif ul_ext == TrackConnection.find_by_name('LR')
      track.lr = self
      track.lr_ext = TrackConnection.find_by_name('UL')
      modified = true
    end
    track.save! if modified
    
    modified = false
    track = cl
    if cl_ext == TrackConnection.find_by_name('UR')
      track.ur = self
      track.ur_ext = TrackConnection.find_by_name('CL')
      modified = true
    elsif cl_ext == TrackConnection.find_by_name('CR')
      track.cr = self
      track.cr_ext = TrackConnection.find_by_name('CL')
      modified = true
    elsif cl_ext == TrackConnection.find_by_name('LR')
      track.lr = self
      track.lr_ext = TrackConnection.find_by_name('CL')
      modified = true
    end
    track.save! if modified
    
    modified = false    
    track = ll
    if ll_ext == TrackConnection.find_by_name('UR')
      track.ur = self
      track.ur_ext = TrackConnection.find_by_name('LL')
      modified = true
    elsif ll_ext == TrackConnection.find_by_name('CR')
      track.cr = self
      track.cr_ext = TrackConnection.find_by_name('LL')
      modified = true
    elsif ll_ext == TrackConnection.find_by_name('LR')
      track.lr = self
      track.lr_ext = TrackConnection.find_by_name('LL')
      modified = true
    end
    track.save! if modified
    
    modified = false
    track = ur
    if ur_ext == TrackConnection.find_by_name('UL')
      track.ul = self
      track.ul_ext = TrackConnection.find_by_name('UR')
      modified = true
    elsif ur_ext == TrackConnection.find_by_name('CL')
      track.cl = self
      track.cl_ext = TrackConnection.find_by_name('UR')
      modified = true
    elsif ur_ext == TrackConnection.find_by_name('LL')
      track.ll = self
      track.ll_ext = TrackConnection.find_by_name('UR')
      modified = true
    end
    track.save! if modified
    
    modified = false
    track = cr
    if cr_ext == TrackConnection.find_by_name('UL')
      track.ul = self
      track.ul_ext = TrackConnection.find_by_name('CR')
      modified = true
    elsif cr_ext == TrackConnection.find_by_name('CL')
      track.cl = self
      track.cl_ext = TrackConnection.find_by_name('CR')
      modified = true
    elsif cr_ext == TrackConnection.find_by_name('LL')
      track.ll = self
      track.ll_ext = TrackConnection.find_by_name('CR')
      modified = true
    end
    track.save! if modified
    
    modified = false
    track = lr
    if lr_ext == TrackConnection.find_by_name('UL')
      track.ul = self
      track.ul_ext = TrackConnection.find_by_name('LR')
      modified = true
    elsif ll_ext == TrackConnection.find_by_name('CL')
      track.cl = self
      track.cl_ext = TrackConnection.find_by_name('LR')
      modified = true
    elsif ll_ext == TrackConnection.find_by_name('LL')
      track.ll = self
      track.ll_ext = TrackConnection.find_by_name('LR')
      modified = true
    end
    track.save! if modified
    
    @@recursion = false
  end  
  
  def disconnect #disconnects all tracks that are connected to this.
    return if @@recursion
    @@recursion = true
    tracks = Track.where(:ul_id => id)
    for track in tracks do
      track.ul = nil
      track.ul_ext = nil
      # puts "ul saving track: #{track.name}"
      track.save!
    end
    tracks = Track.where(:cl_id => id)
    for track in tracks do
      track.cl = nil
      track.cl_ext = nil
      # puts "cl saving track: #{track.name}"
      track.save!
    end
    tracks = Track.where(:ll_id => id)
    for track in tracks do
      track.ll = nil
      track.ll_ext = nil
      # puts "ll saving track: #{track.name}"
      track.save!
    end
    tracks = Track.where(:ur_id => id)
    for track in tracks do
      track.ur = nil
      track.ur_ext = nil
      track.save!
      # puts "ur saving track: #{track.name}"
    end
    tracks = Track.where(:cr_id => id)
    for track in tracks do
      track.cr = nil
      track.cr_ext = nil
      # puts "cr saving track: #{track.name}"
      track.save!
    end
    tracks = Track.where(:lr_id => id)
    for track in tracks do
      track.lr = nil
      track.lr_ext = nil
      # puts "lr saving track: #{track.name}"
      track.save!
    end
    # puts "after save"
    @@recursion = false
  end
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.canCreateOwnTrack? && acting_user == Railroad.find($railroad_branch_section.railroad).user
  end

  def update_permitted?
    acting_user.administrator? || acting_user.canUpdateOwnTrack? && acting_user == section.branch.railroad.user
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user.canDestroyOwnTrack? && acting_user == section.branch.railroad.user
  end

  def view_permitted?(field)
    acting_user.administrator?  || acting_user.canAccessTrack?
  end
  
end
