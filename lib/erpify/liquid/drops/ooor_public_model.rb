require 'erpify/liquid/drops/base'
require 'ooor'

module Erpify
  module Liquid
    module Drops
      class OoorPublicModel < Base

        def before_method(method_or_key)
          if not @@forbidden_attributes.include?(method_or_key.to_s)
            model = Ooor::Base.connection_handler.retrieve_connection(Ooor.default_config).const_get(method_or_key)
            filter_and_order_list(model)
          else
            nil
          end
        end

      end
    end
  end
end
