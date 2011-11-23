class BranchesController < ApplicationController

  hobo_model_controller

  auto_actions :all
  
  def create
    params['branch']['railroad_id'] = railroad_branch_section.railroad.to_s
    hobo_create
    super
  end

  def new
    super
    hobo_new
  end
  
  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index Branch.apply_scopes( :railroad_id_is => railroad_branch_section.railroad, 
                                    :search => [params[:search],:name],
                                    :order_by => parse_sort_param(:name)),
    TablePlusSupport::save_page(params,10,session)
    super
  end
  
 
  def show
    ZLogger::puts "BranchesController::show #{params.inspect}"
    hobo_show
    railroad_branch_section.branch = MyRegexp::get_id_from_param(params[:id])
    super
  end
end
