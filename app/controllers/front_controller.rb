
class FrontController < ApplicationController

  hobo_controller

  def index; 
    ZLogger::puts "FrontController params #{params.inspect}";
    ZLogger::puts "FrontController railroad_branch_section #{railroad_branch_section.inspect}";
    super
    # if (current_user.class != Guest) && current_user.role.to_s == 'Tycoon'
    #   @railroad_name = railroad_branch_section.railroad_name
    #   @branch_name = railroad_branch_section.branch_name
    #   @section_name = railroad_branch_section.section_name
    # end
  end

  def summary
    if !current_user.administrator?
      redirect_to user_login_path
    end
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end
  
  def gpl
  end

end
