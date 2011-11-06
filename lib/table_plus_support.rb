
module TablePlusSupport
  
  WILL_PAGINATE_OPTIONS = [ :page, :per_page, :total_entries, :count, :finder ]

  def self.exclude(model,ignore)
    field_list = ''
    if !ignore.nil? && !model.nil?
      if ignore.is_a? String
        index_fields = model.column_names.select{ |col| col != ignore }
        for i in index_fields do
          field_list = field_list + i + ', '
        end
        field_list = field_list[0..-3]
      end
      if ignore.is_a? Symbol
        index_fields = model.column_names.select{ |col| col != ignore.to_s }
        for i in index_fields do
          field_list = field_list + i + ', '
        end
        field_list = field_list[0..-3]
      end
      if ignore.is_a? Array
        index_fields = model.column_names.select{ |col| !ignore.include? col }
        for i in index_fields do
          field_list = field_list + i + ', '
        end
        field_list = field_list[0..-3]
      end
#      ZLogger::puts "TablePlusSupport.exclude #{field_list}"
    end
    field_list
  end
        
  
  def self.save_page(params, per_page, session, ignore=nil, model=nil,controller=nil)
# If we have fields to ignore (usually ones with much data),
# get a list of all columns excluding them.
    field_list = exclude(model,ignore)
    # puts "save_page field_list: #{field_list.inspect}"
# Default to the first page.
    page = 1
# Generate a session key from the name of the table.
    controller = params[:controller] if controller.nil?
    key = controller+'-page'
    
    if params[:page]
# If we have a page parameter, save it in the session
      page = params[:page].to_i      
      session[key] = page
    else
# If we don't have a page parameter get the page from the session if it exists
      page = session[key] if session[key]
    end
# Return a series of tAssoc to satisfy hobo_index, here I presume that
# pagination is desired since this wouldn't be called without it.
    if ignore.nil? || field_list.blank?
      result = { :per_page => per_page, :page => page, :paginate=> true} 
    else
      result = { :per_page => per_page, :page => page, :paginate=> true, :select => field_list}
    end
    # puts "save_page result:  #{result.inspect}"
    result
  end
  
  def self.save_param(params,param,session,default=nil,controller=nil)
    controller = params[:controller] if controller.nil?
    key = controller + '-' + param.to_s
    sort = nil
    # ZLogger.puts("save_param, params[#{param}]: #{params[param].inspect} default: #{default.to_s}")
    if params[param]
# If we have a value in params[sort], save it in the session
      value = params[param]
      session[key] = value
    else
# The following line is weird.  I tried using session[key].class == 'String',
# but it always evaluated FALSE no matter what version of 'String', "String", :String
# I uaed, even though session[key].class and session[key].class.inspect both printed "String"
# Weirder still, session[key].class == session[key].class.inspect also evaluated FALSE
# This versio works, so ...

# If we don't have a value in params[sort], but we do have a string in session[key]
# then use the value in the key
      if session[key].class.inspect == 'String'
        value = session[key] 
      else
        value = default if default
      end
    end
# set params[param] if we have a value for sort.
    params[param] = value if value  
    # ZLogger.puts "params[#{param}] = #{params[param].inspect} ... default = #{default.inspect}"
  end
  
# The following routines implement the equivalent of hobo_index 
# when the model being used as input to <table-plus> is not the
# primary model for the page.  The specific case this was initially
# developed for was to list real_estate_forms on the show page for
# real_estate_form_topics

  def self.find_or_paginate(finder, options, model, params)
    options = options.reverse_merge(:paginate => model.view_hints.paginate?)
    do_pagination = options.delete(:paginate) && finder.respond_to?(:paginate)
    finder = Array.wrap(options.delete(:scope)).inject(finder) { |a, v| a.send(*Array.wrap(v).flatten) }
    
    options[:order] = finder.default_order unless options[:order] || finder.try.order_values.present?
    
    if do_pagination
      options.reverse_merge!(:page => params[:page] || 1)
      finder.paginate(options)
    else
      finder.all(options.except(*WILL_PAGINATE_OPTIONS))
    end
  end
  
  def self.hobo_index(model, params, *args, &b)
    options = args.extract_options!
    finder = args.first || model
    result = find_or_paginate(finder, options, model, params)
    result
  end

  
end