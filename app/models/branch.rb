class Branch < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string, :required
    timestamps
  end

  validates_uniqueness_of :name, :scope => :railroad_id
  
  belongs_to :railroad, :creator => true
  has_many :sections, :dependent => :destroy
  
  # --- Permissions --- #

  def create_permitted?
    ZLogger::puts "create_permitted: #{railroad.inspect}"
    acting_user.administrator? || acting_user.canCreateOwnBranch? && acting_user == Railroad.find($railroad_branch_section.railroad).user
  end

  def update_permitted?
    ZLogger::puts "update_permitted: #{railroad.inspect}"
    acting_user.administrator? || acting_user.canUpdateOwnBranch? && acting_user == railroad.user
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user.canDestroyOwnBranch? && acting_user == railroad.user
  end

  def view_permitted?(field)
    acting_user.administrator?  || acting_user.canAccessBranch?
  end
  
end
