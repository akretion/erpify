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

        def initialize(tag_name, arguments_string, tokens, context = {})
          # convert symbol operators into valid ruby code
          arguments_string.gsub!(SYMBOL_OPERATORS_REGEXP, ':"\1" =>')

          super(tag_name, arguments_string, tokens, context)
        end

        def display(options = {}, &block)
          current_context.stack do
            current_context['with_domain'] = self.decode(options)
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
      end
    end
  end
end
