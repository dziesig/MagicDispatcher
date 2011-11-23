# Copyright (c) 2011 by Donald R. Ziesig.  All Rights Reserved
# 
#     This file is part of MagicDispatcher.
# 
#     MagicDispatcher is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     MagicDispatcher is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with MagicDispatcher.  If not, see <http://www.gnu.org/licenses/>.

class Railroad < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string, :unique, :required
    north_south :boolean, :default => false
    west_south_on_right :boolean, :default => false
    eastbound_odd_numbers :boolean, :default => false
    timestamps
  end

  belongs_to :user, :creator => true
  
  has_many :branches, :dependent => :destroy
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator? || acting_user.canCreateRailroad?
  end

  def update_permitted?
    acting_user.administrator?  || acting_user.canUpdateOwnRailroad? && acting_user == user
  end

  def destroy_permitted?
    acting_user.administrator?  || acting_user.canDestroyOwnRailroad? && acting_user == user
  end

  def view_permitted?(field)
    acting_user.administrator?  || acting_user.canAccessRailroad?
  end

end
