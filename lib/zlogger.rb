module ZLogger
  
  @filename
  
  def ZLogger.force_log
    if ENV['ZLOG']
      if ENV['ZLOG'] == 'true'
        return true
      end
    end
    false
  end
  
  def ZLogger.assign(filename)
    @filename = filename
    if self.force_log
      @filename = @filename + '_force.log'
    else
      @filename = @filename + '.log'
    end
    if (Rails.env == 'development' || force_log) && @filename
      f = File.new(@filename,'w')
      f.puts "force_log:  #{self.force_log.inspect}"
      f.flush
      f.close
    end
  end
  
  def ZLogger.put(str)
    if (Rails.env == 'development' || force_log) && @filename
      f = File.new(@filename,"a")
      f.put(str)
      f.flush
      f.close
    end    
  end
  
  def ZLogger.puts(str)
    if (Rails.env == 'development' || force_log) && @filename
      f = File.new(@filename,"a")
      f.puts(Time::now().to_s + ' ' + str)
      f.flush
      f.close
    end    
  end
end