require 'erpify/liquid/drops/base'
require 'ooor'

module Erpify
  module Liquid
    module Drops
      class Ooor < Base

        def before_method(method_or_key)
          if not @@forbidden_attributes.include?(method_or_key.to_s)
            conn = ::Ooor::Base.connection_handler.user_connection(@context['email'])
            value = conn.const_get(method_or_key)
            filter_and_order_list(value)
          else
            nil
          end
        end

        protected

        def filter_and_order_list(list)
          # filter ?
          if @context['with_domain']
            conditions  = HashWithIndifferentAccess.new(@context['with_domain'])
            order_by    = conditions.delete(:order_by).try(:split)
            offset      = conditions.delete(:offset)
            limit       = conditions.delete(:limit)
            fields      = conditions.delete(:fields).try(:split)
            context = @context['context'] #FIXME not very cool
            list.where(conditions).offset(offset).limit(limit).order(order_by).all(fields: fields, context: context || {})
          else
            list.all(context: @context['context'] || {})
          end
        end

      end
    end
  end
end
