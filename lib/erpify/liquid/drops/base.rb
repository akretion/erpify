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
          if options = @context['with_domain']
            conditions  = options.delete(:domain)
            order_by    = options.delete(:order_by).try(:split)
            offset      = options.delete(:offset)
            limit       = options.delete(:limit)
            options[:fields] = false unless options[:fields]
            options[:context] = {} unless options[:context] #TODO improve
            model.where(conditions).offset(offset).limit(limit).order(order_by).all(options)
          else
            model.all(context: @context['context'] || {})
          end
        end

      end
    end
  end
end
