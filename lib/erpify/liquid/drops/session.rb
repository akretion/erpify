# Liquify taken from Mephisto sources (http://mephistoblog.com/)
module Erpify
  module Liquid
    module Drops
      class Session < ::Liquid::Drop

        @@forbidden_attributes = %w{_id _version _index}

        attr_reader :_source

        def initialize(source=nil)
          @_source = source
        end

        def csrf_token
          @_source.common.csrf_token
        end

      end
    end
  end
end
