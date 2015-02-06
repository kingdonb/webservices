module Websevices

class Caching
  def self.smart_fetch(name, options = {}, &blk)
    in_cache = Rails.cache.fetch(name)
    return in_cache if in_cache
    if block_given? 
      val = yield 
      Rails.cache.write(name, val, options) 
      return val 
    end 
  end
end

end