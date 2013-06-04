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
      class WithDomain < ::Liquid::Block

        TagAttributes = /(\w+|\w+\.\w+)\s*\:\s*(#{::Liquid::QuotedFragment})/

        def initialize(tag_name, markup, tokens, context)
          @attributes = HashWithIndifferentAccess.new
          markup.scan(TagAttributes) do |key, value|
#            k, operator = extract_operator(key)
#            @attributes[k] = [k, operator, value]
             @attributes[key] = value
          end
          super
        end

        def render(context)
          context.stack do
            context['with_domain'] = decode(@attributes.clone, context)
            render_all(@nodelist, context)
          end
        end

        private

        def decode(attributes, context)
          attributes.each_pair do |key, value|
            attributes[key] = context[value]
          end
        end

        def extract_operator(key)
          if %w(gt gte in lt lte ne eq ilike).include?(key.split('.').last)
            operator = key.split('.').last
            key = key.gsub(/\.#{operator}$/, '')
          else
            operator = "="
          end
          return key, operator
        end
      end

      ::Liquid::Template.register_tag('with_domain', WithDomain)
    end
  end
end
