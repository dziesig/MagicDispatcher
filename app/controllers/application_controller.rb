include ApplicationHelper

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  $railroad_branch_section = nil
    
  private
  
  def railroad_branch_section
    session[:railroad_branch_section] ||= RailroadBranchSection.new
    $railroad_branch_section = session[:railroad_branch_section]
  end
  
  public
  
  def index
    populate_header
  end
  
  def show
    populate_header
  end
  
  def create
    populate_header
  end
  
  def new
    populate_header
  end
  
  def edit
    populate_header
    super
  end
  
  private
  
  def populate_header
    if (current_user.class != Guest) && (current_user.role.to_s == 'Tycoon')
      if !railroad_branch_section.railroad_ok?
        $hide_tabs = Array.new(['Branch', 'Section', 'Track'])
      elsif !railroad_branch_section.branch_ok?
        $hide_tabs = Array.new(['Section', 'Track'])
      elsif !railroad_branch_section.section_ok?
        $hide_tabs = Array.new(['Track'])
      else  
        $hide_tabs = Array.new
      end
    end
    if (current_user.class != Guest) && (current_user.role.to_s == 'Tycoon')
      @railroad_name = railroad_branch_section.railroad_name
      @branch_name = railroad_branch_section.branch_name
      @section_name = railroad_branch_section.section_name
    end
  end
    
end
