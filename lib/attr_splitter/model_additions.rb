module AttrSplitter
  module ModelAdditions
    def attr_splitter(attribute, args)
      placement = args.include?(:prefixes) ? :prefixes : :suffixes
      fields = args[placement]
      unless fields
        raise "AttrSplitter: no prefixes or suffixes specified"
      end
      split_attrs = fields.collect do |f|
        if placement == :prefixes
          [f.to_s, attribute.to_s].join("_").to_sym
        else
          [attribute.to_s, f.to_s].join("_").to_sym
        end
      end

      split_attrs.each do |sa|
        define_method(sa) do
          instance_variable_get("@#{sa.to_s}")
        end
        define_method("#{sa.to_s}=") do |val|
          instance_variable_set("@#{sa.to_s}", val)
        end
      end

      before_save do
        combined_value = split_attrs.collect{ |sa| send(sa.to_s) }.join
        send("#{attribute}=", combined_value)
      end
    end
  end
end