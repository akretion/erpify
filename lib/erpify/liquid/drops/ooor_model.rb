require 'erpify/liquid/drops/base'
require 'ooor'

module Erpify
  module Liquid
    module Drops
      class OoorModel < Base

        def before_method(method_or_key)
          if not @@forbidden_attributes.include?(method_or_key.to_s)
            model = _source.const_get(method_or_key)
            filter_and_order_list(model)
          else
            nil
          end
        end

      end
    end
  end
end
