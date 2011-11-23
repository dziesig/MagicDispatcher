class Admin::TrackTypesController < Admin::AdminSiteController

  hobo_model_controller

  auto_actions :all

  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index TrackType.apply_scopes(:search => [params[:search],:name,:index],
                                  :order_by => 
      parse_sort_param(:name,:index)), 
                     TablePlusSupport::save_page(params,10,session)
  end
end
