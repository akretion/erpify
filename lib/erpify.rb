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

module Erpify
  module Liquid
    module Tags

      class ErpFind < ::Liquid::Tag
        Syntax = /(#{::Liquid::VariableSignature}+)\s*=\s*(?:#{::Liquid::Expression}+)\s*/o
        def initialize(tag_name, markup, tokens, context)
          @options = {object: 'product.product', domain: '[]', fields: false, context: {}}
          if markup =~ Syntax
            @to = $1
            markup.scan(::Liquid::TagAttributes) { |key, value| @options[key.to_sym] = value.gsub(/"|'/, '') }
          else
            raise ::Liquid::SyntaxError.new("Syntax Error in ErpFind Tag")
          end
          super
        end

        def render(context)
          conn = Ooor::Base.connection_handler.user_connection() #TODO email in session
          erp_obj = conn.const_get(@options[:object])
          domain = eval(@options[:domain]) #FIXME we don't wan't an eval!! use regexp instead?
          context.scopes.last[@to] = erp_obj.find(:all, domain: domain, fields:@options[:fields], context: @options[:context])
          ''
        end
      end

    ::Liquid::Template.register_tag('erp_find', ErpFind)
    end
  end
end
