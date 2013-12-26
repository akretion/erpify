# Liquify taken from Mephisto sources (http://mephistoblog.com/)
module Erpify
  module Liquid
    module Drops
      class Base < ::Liquid::Drop

        @@forbidden_attributes = %w{_id _version _index}

        attr_reader :_source

        def initialize(source=nil)
          @_source = source
        end

        def id
          (@_source.respond_to?(:id) ? @_source.id : nil) || 'new'
        end

        # converts an array of records to an array of liquid drops
        def self.liquify(*records, &block)
          i = -1
          records =
            records.inject [] do |all, r|
              i+=1
              attrs = (block && block.arity == 1) ? [r] : [r, i]
              all << (block ? block.call(*attrs) : r.to_liquid)
              all
            end
          records.compact!   
          records
        end

        protected

        def liquify(*records, &block) 
          self.class.liquify(*records, &block)
        end 
    
        def filter_and_order_list(model)
          if @context['with_domain']
            conditions  = @context['with_domain']
            order_by    = conditions.delete(:order_by).try(:split)
            offset      = conditions.delete(:offset)
            limit       = conditions.delete(:limit)
            fields      = conditions.delete(:fields).try(:split)
            context = @context['context'] #FIXME not very cool
            model.where(conditions).offset(offset).limit(limit).order(order_by).all(fields: fields, context: context || {})
          else
            model.all(context: @context['context'] || {})
          end
        end

      end
    end
  end
end
