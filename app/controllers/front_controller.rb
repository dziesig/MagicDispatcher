class FrontController < ApplicationController

  hobo_controller

  def index; 
    ZLogger::puts "FrontController params #{params.inspect}";
    if current_user.role.to_s == 'Tycoon'
      @railroads = Railroad.find(:all)
    end
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
