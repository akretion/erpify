module Erpify
  module Liquid
    module Filters

     def groupable?(element)
       element.respond_to?(:group_by)
     end

      def item_property(item, property)
        if item.respond_to?(:to_liquid)
          item.to_liquid[property.to_s]
        elsif item.respond_to?(:data)
          item.data[property.to_s]
        else
          item[property.to_s]
        end
      end

      # Group an array of items by a property
      #
      # input - the inputted Enumerable
      # property - the property
      #
      # Returns an array of Hashes, each looking something like this:
      #  {"name"  => "larry"
      #   "items" => [...] } # all the items where `property` == "larry"
      def group_by(input, property)
        if groupable?(input)
          input.group_by do |item|
          item_prop = item_property(item, property)
          if item_prop.is_a? Ooor::Base
            [item_prop.id, item_prop._display_name]
          elsif item_prop.is_a?(Array) && item_prop.size ==2
            item_prop
          else
            [nil, item_prop.to_s]
          end
          # TODO give access to the key object. Strangely putting item_prop as last array item seems to screw the feature
          end.inject([]) do |memo, i|
            memo << { "id" => i.first[0], "name" => i.first[1], "items" => i.last, "size" => i.last.size }
          end
        else
          input
        end
      end


    end

    ::Liquid::Template.register_filter(Filters)
  end
end
