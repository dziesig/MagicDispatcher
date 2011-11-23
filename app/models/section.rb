class Section < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string, :required
    arrival_instructions :text
    timestamps
  end

  belongs_to :branch, :creator => true
  has_many :tracks, :dependent => :destroy
  
  validates_uniqueness_of :name, :scope => :branch_id
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.canCreateOwnSection? && acting_user == Railroad.find($railroad_branch_section.railroad).user
  end

  def update_permitted?
    acting_user.administrator? || acting_user.canUpdateOwnSection? && acting_user == branch.railroad.user
  end

  def destroy_permitted?
    acting_user.administrator? || acting_user.canDestroyOwnSection? && acting_user == branch.railroad.user
  end

  def view_permitted?(field)
    acting_user.administrator?  || acting_user.canAccessSection?
  end

end
