class SectionsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def create
    ZLogger::puts "SectionsController.create #{params.inspect}"
    super
    params['section']['branch_id'] = railroad_branch_section.branch.to_s
    hobo_create
  end
  
  def new
    ZLogger::puts "SectionsController.new #{params.inspect}"
    super
    hobo_new
  end
  
  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index Section.apply_scopes(  :branch_id_is => railroad_branch_section.branch,
                                      :search => [params[:search],:name],
                                      :order_by => parse_sort_param(:name)),
    TablePlusSupport::save_page(params,10,session)
    super
  end
  
  def show
    hobo_show
    railroad_branch_section.section = MyRegexp::get_id_from_param(params[:id])
    super
  end
end
