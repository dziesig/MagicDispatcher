module MyRegexp
  def MyRegexp.get_id_from_redirect( directed_to, source )
    r = Regexp.new(directed_to+'\/\d+')
#    puts "RRRRRR #{r.inspect}"
    result = r.match(source)[0]
#    puts "RRRRRR #{result.inspect}"
    result = /\d+/.match(result)[0].to_i
#    puts "RRRRRR #{result.inspect}"
    result
  end
  
  def MyRegexp.get_id_from_param( source )
    result = /\d+/.match(source)[0].to_i
  end
  
  def MyRegexp.hobo_id( source )
    r = Regexp.new('\d')
    result = r.match(source)[0]
  end
    
end
    