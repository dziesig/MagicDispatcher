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
require './lib/myregexp.rb';

class RailroadsController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def create
    super
    hobo_create
  end
  
  def new
    super
    hobo_new
  end
  
  # def edit
  #   super
  # end
  
  def index
    TablePlusSupport::save_param(params,:sort,session,'name')
    TablePlusSupport::save_param(params,:search,session)
    hobo_index Railroad.apply_scopes(:search => [params[:search],:name],
                                  :order_by => 
      parse_sort_param(:name)),
    TablePlusSupport::save_page(params,10,session)
    super
  end
  
  def show
    hobo_show
    railroad_branch_section.railroad = MyRegexp::get_id_from_param(params[:id])
    super
  end
end
