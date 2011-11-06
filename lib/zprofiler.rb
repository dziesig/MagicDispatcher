module ZProfiler
  
  class Invocation
    attr_accessor :name, :global, :local
    
    def initialize( name, global, local)
      @name = name
      @global = global
      @local = local
    end
  end
  
  class Duration
    attr_accessor :global, :count, :local
    
    def initialize( global, local, count )
      @global = global
      @count = count
      @local = local
    end
  end
  
  @filename
  
  @sp = 0
  @stack = Array.new
  @duration = Hash.new
  
  def ZProfiler.assign( filename )
    return if ENV['HEROKU']
    if Rails.env == 'development'
      @filename = filename
    else
      @filename = filename + '_prod'
    end
    fn = @filename + '.csv'
    f = File.new(fn,'w')
    f.close
  end
  
  def ZProfiler.start( name )
    return if ENV['HEROKU']
    # ZLogger::puts "ZProfiler.start (#{name})"
    time = Time.now
    @stack[@sp] = Invocation.new(name,time,time)
    @sp = @sp + 1
  end
  
  def ZProfiler.reset
    return if ENV['HEROKU']
    @sp = 0
    @stack = Array.new
    @duration = Hash.new
    fn = @filename + '.csv'
    f = File.new(fn,'w')
    f.close
  end
  
  def ZProfiler.finish( name )
    return if ENV['HEROKU']
    # ZLogger::puts "ZProfiler.finish (#{name})"
    @sp = @sp -1
    raise "Profile Underflow" if @sp < 0
    raise "Profile Mismatch #{@stack[@sp].name} |= #{name}" if @stack[@sp].name != name
    time = Time.now
    top = @stack[@sp]
    global_time = time - top.global
    local_time = time - top.local
    
    if @sp > 0
      @stack[@sp-1].local = @stack[@sp-1].local + global_time
    end
    
    # duration = Duration.new(global_time, local_time, 1)

    if @duration[name]
      lcl_dur = @duration[name]
      
      dur = Duration.new(lcl_dur.global + global_time, lcl_dur.local + local_time, lcl_dur.count + 1)
      @duration[name] = dur
    else
      @duration.merge!({name => Duration.new(global_time, local_time, 1)})
    end
    fn = @filename + '.csv'
    f = File.new(fn,'w')
    f.printf("Code,Global Time,Avg. Global Time, Local Time, Avg. Local Time, Count\n")
    @duration.each do | key, value |
      f.printf("\"%s\",%4.3f,%4.3f,%4.3f,%4.3f,%d\n", key, value.global, value.global/value.count, value.local, value.local/value.count,value.count)
    end
    f.close
  end
  
end