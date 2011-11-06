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

class User < ActiveRecord::Base

  hobo_user_model # Don't put anything above this

  fields do
    name          :string, :required, :unique
    email_address :email_address, :login => true
    administrator :boolean, :default => false
    use_secondary_role 	:boolean, :default => false #when true, user assumes secondary role
    timestamps
  end

  never_show :use_secondary_role
  
  belongs_to  :primary_role, :class_name => "Role"
  belongs_to  :secondary_role, :class_name => "Role"
  delegate    :permissions, :to => :role
  
  has_many    :railroads, :dependent => :destroy
  
  def role
    if self.use_secondary_role?
      self.secondary_role
    else
      self.primary_role
    end
  end
  
  def alternate_role
    if self.use_secondary_role?
      self.primary_role
    else
      self.secondary_role
    end
  end    

  def toggle_mode
    self.use_secondary_role = !self.use_secondary_role
    self.save!
  end
  
# set default roles 
  before_save do |user|
    self.primary_role = Role.find_by_name('Tycoon') if self.primary_role.nil?
    self.secondary_role = Role.find_by_name('Dispatcher') if self.secondary_role.nil?
  end
  
  # This gives admin rights and an :active state to the first sign-up.
  # Just remove it if you don't want that
  before_create do |user|
    if !Rails.env.test? && user.class.count == 0
      user.administrator = true
      user.state = "active"
    end
  end


  # --- Signup lifecycle --- #

  lifecycle do

    state :active, :default => true

    create :signup, :available_to => "Guest",
           :params => [:name, :email_address, :password, :password_confirmation],
           :become => :active

    transition :request_password_reset, { :active => :active }, :new_key => true do
      UserMailer.forgot_password(self, lifecycle.key).deliver
    end

    transition :reset_password, { :active => :active }, :available_to => :key_holder,
               :params => [ :password, :password_confirmation ]

  end

  # --- Permissions --- #

  def create_permitted?
    # Only the initial admin user can be created
    self.class.count == 0
  end

  def update_permitted?
    acting_user.administrator? ||
      (acting_user == self && only_changed?(:email_address, :crypted_password,
                                            :current_password, :password, :password_confirmation))
    # Note: crypted_password has attr_protected so although it is permitted to change, it cannot be changed
    # directly from a form submission.
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end
  
#--------------------------------------------------------------------
# Roles, Permissions, has_multiple_roles
#--------------------------------------------------------------------

  def method_missing(method_id, *args)
    if match = matches_dynamic_role_check?(method_id)
      tokenize_roles(match.captures.first).each do |check|
        if self.role.name.downcase == check
          return true
        end
      end
      return false
    elsif match = matches_dynamic_perm_check?(method_id)
      if !permissions.nil? 
        result = permissions.find_by_name(match.captures.first)
        return result
      end
    else
      super
    end
  end

  def has_multiple_roles?
    if self.secondary_role != nil
      return self.secondary_role != self.primary_role unless self.secondary_role.name == 'Unassigned'
    end
    false
  end
 
  private
  
  def matches_dynamic_role_check?(method_id)
    /^is_an?_([a-zA-Z]\w*)\?$/.match(method_id.to_s)
  end
 
  def tokenize_roles(string_to_split)
    string_to_split.split(/_or_/)
  end

  def matches_dynamic_perm_check?(method_id)
    result = /^can([a-zA-Z]\w*)\?$/.match(method_id.to_s)
    result
  end
  
end
