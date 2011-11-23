class TracksController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def create
    ZLogger::puts "TracksController.create #{params.inspect}"
    @editing = false
    super
    params['track']['section_id'] = railroad_branch_section.section.to_s
    hobo_create
  end
  
  def new
    ZLogger::puts "TracksController.new #{params.inspect}"
    @editing = false
    super
    hobo_new
  end
  
  def update
    ZLogger::puts "TracksController.update #{params.inspect}"
    @editing = true
    hobo_update
    ZLogger::puts "@editing #{@editing.inspect}"
  end
  
  def edit
    @this = Track.find(params[:id])
    @track = @this
    ZLogger::puts "TracksController.edit #{@this.inspect}"   
  end
  
  def show
    super
    hobo_show
    # @this = Track.find(params[:id])
    # ZLogger::puts "TracksController.edit #{@this.inspect}"
  end
  
  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index Track.apply_scopes(  :section_id_is => railroad_branch_section.section,
                                      :search => [params[:search],:name],
                                      :order_by => parse_sort_param(:name)),
    TablePlusSupport::save_page(params,10,session)
    super
  end
  
  def ajax
    ZLogger::puts "tracks.ajax:  #{params.inspect}"
  end
  
end
