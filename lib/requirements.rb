require 'scanf'
require 'digest/md5'

class Array

  def scale(top)
    case top
      when Numeric; ratio = max.to_f/top
      when Array; ratio = zip(top).map {|a,b| b ? a.to_f/b : 0}.max
      else raise TypeError, "number or array of numbers expected, #{top.class} given"
    end
    map {|e| e/ratio}
  end
  
end

module ActiveRecord
  class Base
    
    def to_hash
      Serializer.new(self).serializable_record
    end
    
  end
end