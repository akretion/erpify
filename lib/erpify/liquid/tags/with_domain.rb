module Erpify
  module Liquid
    module Tags

      # Filter a collection
      #
      # Usage:
      #
      # {% with_domain main_developer: 'John Doe', active: true %}
      #   {% for project in ooor['project.project'] %}
      #     {{ project.name }}
      #   {% endfor %}
      # {% endwith_domain %}
      #
      class WithDomain < Solid::Block

        OPERATORS = ['=', '!=', '<=', '<', '>', '>=', '=?', '=like', '=ilike', 'like', 'not like', 'ilike', 'not ilike', 'in', 'not in', 'child_of']

        SYMBOL_OPERATORS_REGEXP = /(\w+\.(#{OPERATORS.join('|')})){1}\s*\:/

        # register the tag
        tag_name :with_domain

        def initialize(name, markup, options)
          # convert symbol operators into valid ruby code
          markup.gsub!(SYMBOL_OPERATORS_REGEXP, ':"\1" =>')

          super(name, markup, options)
        end

        def display(options = {}, &block)
          current_context.stack do
            if options.is_a?(Array)
              current_context['with_domain'] = {domain: options}
            elsif options[0].is_a?(Array) && options[1].is_a?(Hash)
              current_context['with_domain'] = options[1].merge({domain: options[0]})
            else
              if options[:domain]
                current_context['with_domain'] = options
              else
                options[:domain] = self.decode(options.except(:fields, :order_by, :offset, :limit, :fields, :include, :only, :context))
                current_context['with_domain'] = options
              end
            end
            yield
          end
        end

        protected

        def decode(options)
          domain = []
          options.each do |key, value|
            _key, _operator = key.to_s.split('.')
            if _operator
              domain << [_key, _operator, value]
            else
              domain << [_key, '=', value]
            end
          end
          return domain
        end

      ::Liquid::Template.register_tag('with_domain'.freeze, WithDomain)
      end
    end
  end
end
