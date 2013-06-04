require 'erpify/liquid'
require 'ooor'

class Ooor::Base
  def to_liquid
    self
  end

  def has_key?(key)
    true
  end

  def [](key)
    send key
  end
end
