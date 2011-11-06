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

class Admin::RolesController < Admin::AdminSiteController

  hobo_model_controller

  auto_actions :all

  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index Role.apply_scopes(:search => [params[:search],:name],
                                  :order_by => 
      parse_sort_param(:name)), 
                     TablePlusSupport::save_page(params,10,session)
  end
end
